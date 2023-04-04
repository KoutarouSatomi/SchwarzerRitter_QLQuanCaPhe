using QLQuanCaPhe.DTO;
using System.Data;

namespace QLQuanCaPhe.DAO
{
    public class TypeMemberDAO
    {
        private static TypeMemberDAO instance;

        public static TypeMemberDAO Instance
        {
            get { if (instance == null) instance = new TypeMemberDAO(); return instance; }
            private set { instance = value; }
        }
        private TypeMemberDAO() { }

        //các hàm
        public DataTable GetMemberTypeList()
        {
            string query = "exec USP_GetTypeMemberList";
            return DataProvider.Instance.ExecuteQuery(query);
        }
        public TypeMember GetTypeMemberNameByID(int id)
        {
            TypeMember typeMember = null;
            string query = "SELECT * FROM dbo.typeMember where idRole = " + id;

            DataTable data = DataProvider.Instance.ExecuteQuery(query);

            foreach (DataRow item in data.Rows)
            {
                typeMember = new TypeMember(item);
                return typeMember;
            }
            return typeMember;
        }
    }
}
