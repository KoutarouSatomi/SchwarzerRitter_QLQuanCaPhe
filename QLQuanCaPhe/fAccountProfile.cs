using QLQuanCaPhe.DAO;
using QLQuanCaPhe.DTO;
using System;
using System.Drawing;
using System.Windows.Forms;

namespace QLQuanCaPhe
{
    public partial class fAccountProfile : Form
    {
        private Account loginAccount; //tạo loginAccout với kiểu là Account

        public Account LoginAccount //định nghĩa
        {
            get { return loginAccount; }
            set { loginAccount = value; ChangeAccount(LoginAccount); }
        }
        public fAccountProfile(Account acc)
        {
            InitializeComponent();
            loadForm();
            LoginAccount = acc;
        }

        //tinh chỉnh giao diện
        void loadForm()
        {
            lbProfile.BackColor = Color.Transparent;
            this.BackgroundImage = Properties.Resources.profileBackground2;
            this.Icon = Properties.Resources.logo;
            panel1.BackColor = Color.Transparent;
            panel2.BackColor = Color.Transparent;
            panel3.BackColor = Color.Transparent;
            panel4.BackColor = Color.Transparent;
            panel5.BackColor = Color.Transparent;
        }
        //Hiển thị tên đăng nhập và tên hiển thị vào trong TextBox
        void ChangeAccount(Account acc)
        {
            txbUserName.Text = LoginAccount.UserName;
            txbDisplayName.Text = LoginAccount.DisplayName;

        }
        //cập nhật thông tin account
        void UpdateAccountInfo()
        {
            string displayName = txbDisplayName.Text;
            string password = txbPassword.Text;
            string newPass = txbNewPassword.Text;
            string reEnterPass = txbReEnterPassword.Text;
            string userName = txbUserName.Text;

            if (!newPass.Equals(reEnterPass))
            {
                MessageBox.Show("Mật khẩu nhập lại và mật khẩu mới không trùng khớp");
            }
            else
            {
                if (AccountDAO.Instance.UpdateAcount(userName, displayName, password, newPass))
                {
                    DialogResult result = MessageBox.Show("Xác nhận cập nhật thông tin tài khoản", "Thông báo", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
                    if (result == DialogResult.Yes)
                    {
                        MessageBox.Show("Cập nhật thông tin thành công", "thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        if (updateAcount != null)
                        {
                            updateAcount(this, new AccountEvent(AccountDAO.Instance.GetAccountByUserName(userName)));
                        }
                    }

                }
                else
                {
                    MessageBox.Show("Không thành công!  Vui lòng thực hiện lại!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
        }
        //tạo event để chuyển thông tin từ thằng con Profile sang thằng cha Management
        private event EventHandler<AccountEvent> updateAcount;
        public event EventHandler<AccountEvent> UpdateAcount
        {
            add { updateAcount += value; }
            remove { updateAcount -= value; }
        }
        private void btnExit_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnUpdate_Click(object sender, EventArgs e)
        {
            UpdateAccountInfo();
        }
    }
    public class AccountEvent : EventArgs
    {
        private Account acc;

        public Account Acc
        {
            get { return acc; }
            set { acc = value; }
        }
        public AccountEvent(Account acc)
        {
            this.Acc = acc;
        }
    }
}
