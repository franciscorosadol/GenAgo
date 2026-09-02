using System.ComponentModel.DataAnnotations;

namespace ControlEscolar.Models
{
    public class Alumno
    {
        [Key]
        public int Matricula { get; set; }
        public string nombre { get; set; }
        public string direccion { get; set; }
        public string apellidoPaterno { get; set; }
        public string apellidoMaterno { get; set; }
        public string correo { get; set; }
        public string telefono { get; set; }
    }
}
