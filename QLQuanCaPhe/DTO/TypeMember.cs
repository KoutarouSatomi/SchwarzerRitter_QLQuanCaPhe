using System.Data;

namespace QLQuanCaPhe.DTO
{
    public class TypeMember
    {
        public TypeMember(int idRole, string typeName)
        {
            this.IdRole = idRole;
            this.TypeName = typeName;
        }

        public TypeMember(DataRow row)
        {
            this.IdRole = (int)row["idRole"];
            this.TypeName = row["typeName"].ToString();
        }

        private int idRole;
        private string typeName;

        public int IdRole { get => idRole; set => idRole = value; }
        public string TypeName { get => typeName; set => typeName = value; }
    }
}
