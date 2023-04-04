using System.Data;

namespace QLQuanCaPhe.DTO
{
    public class Member
    {
        public Member(int id, string nameMember, string mSSV, int role)
        {
            this.Id = id;
            this.NameMember = nameMember;
            this.MSSV = mSSV;
            this.Role = role;
        }

        public Member(DataRow row)
        {
            this.Id = (int)row["id"];
            this.NameMember = row["memberName"].ToString();
            this.MSSV = row["mssvMember"].ToString();
            this.Role = (int)row["role"];
        }

        int id;
        string nameMember;
        string mSSV;
        int role;

        public int Id { get => id; set => id = value; }
        public string NameMember { get => nameMember; set => nameMember = value; }
        public string MSSV { get => mSSV; set => mSSV = value; }
        public int Role { get => role; set => role = value; }
    }
}
