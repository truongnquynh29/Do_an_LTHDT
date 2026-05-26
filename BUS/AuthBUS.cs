using LocknLockManagement.DAL.Repositories;
using LocknLockManagement.DTO;
using LocknLockManagement.Helpers;

namespace LocknLockManagement.BUS
{
    public class AuthBUS
    {
        private readonly AccountDAL _accountDAL = new AccountDAL();

        /// <summary>
        /// Đăng nhập. Trả về AccountDTO nếu thành công, null nếu sai.
        /// </summary>
        public AccountDTO Login(string username, string password, out string error)
        {
            error = "";

            if (string.IsNullOrWhiteSpace(username))
            {
                error = "Vui lòng nhập tên đăng nhập";
                return null;
            }
            if (string.IsNullOrWhiteSpace(password))
            {
                error = "Vui lòng nhập mật khẩu";
                return null;
            }

            string passwordHash = PasswordHashHelper.Hash(password);
            AccountDTO account = _accountDAL.GetByCredentials(username, passwordHash);

            if (account == null)
            {
                error = "Tên đăng nhập hoặc mật khẩu không đúng";
                return null;
            }
            if (!account.IsActive)
            {
                error = "Tài khoản đã bị khóa, vui lòng liên hệ Admin";
                return null;
            }

            // Lưu session
            SessionManager.SetCurrentUser(account);
            return account;
        }

        public void Logout()
        {
            SessionManager.Logout();
        }

        public bool ChangePassword(int accountId, string oldPassword, string newPassword, out string error)
        {
            error = "";
            var account = _accountDAL.GetById(accountId);
            if (account == null) { error = "Tài khoản không tồn tại"; return false; }

            if (!PasswordHashHelper.Verify(oldPassword, account.PasswordHash))
            {
                error = "Mật khẩu cũ không đúng";
                return false;
            }
            if (newPassword.Length < 6)
            {
                error = "Mật khẩu mới phải có ít nhất 6 ký tự";
                return false;
            }

            string newHash = PasswordHashHelper.Hash(newPassword);
            return _accountDAL.UpdatePassword(accountId, newHash);
        }
    }
}