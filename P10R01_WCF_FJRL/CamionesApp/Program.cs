using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CamionesApp.ServiceReference1;

namespace CamionesApp
{
    internal class Program
    {
        static void Main(string[] args)
        {
            // Crear objetos del cliente
            Service1Client cliente = new Service1Client();
            try
            {
                // Obtener y mostrar los camiones
                string[] camiones = cliente.ObetenerCamiones();

                Console.WriteLine("Matriculas en la base de datos:");
                foreach (string matricula in camiones)
                {
                    Console.WriteLine("- " + matricula);
                }

                // Obtener y mostrar los choferes
                string[] choferes = cliente.ObetenerChoferes();

                Console.WriteLine("Choferes en la base de datos:");
                foreach (string nombre in choferes)
                {
                    Console.WriteLine("- " + nombre);
                }

                // Cerrar la conexión
                cliente.Close();
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: " + ex.Message);
            }
            Console.ReadKey();
        }
    }
}