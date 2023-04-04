using System.Data;

namespace QLQuanCaPhe.DAO
{
    public class MemberDAO
    {
        //Tạo cấu trúc singleTon cho Member DAO
        private static MemberDAO instance;

        public static MemberDAO Instance
        {
            get { if (instance == null) instance = new MemberDAO(); return MemberDAO.instance; }
            private set { instance = value; }
        }
        private MemberDAO() { }


        //hàm lấy danh sách thành viên nhóm
        public DataTable GetListMember()
        {
            string query = "EXEC USP_GetMemberAndType";
            return DataProvider.Instance.ExecuteQuery(query);
        }

        //insert member
        public bool InsertMember(string nameMember, string mssvMember, int role)
        {
            string query = string.Format("exec USP_InsertMember @nameMember = N'{0}' , @mssvMember = N'{1}' , @role = {2}", nameMember, mssvMember, role);
            int result = DataProvider.Instance.ExecuteNonQuery(query);
            return result > 0;
        }
        //sửa thông tin thành viên
        public bool UpdateMember(int id, string nameMember, string mssvMember, int role)
        {
            string query = string.Format("exec USP_UpdateMember @id = {0} , @nameMember = N'{1}' , @mssvMember = N'{2}' , @role = {3}", id, nameMember, mssvMember, role);
            int result = DataProvider.Instance.ExecuteNonQuery(query);
            return result > 0;
        }

        //xóa thành viên nhóm
        public bool DeleteMember(int id)
        {
            string query = string.Format("exec USP_DeleteMember @idMember = {0}", id);
            int result = DataProvider.Instance.ExecuteNonQuery(query);
            return result > 0;
        }
    }
}
