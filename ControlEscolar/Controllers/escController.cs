using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using ControlEscolar.Models;
using ControlEscolar.Context;
using Microsoft.EntityFrameworkCore;

namespace ControlEscolar.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class escController : ControllerBase
    {
        private readonly AppDbContext conEsc;

        public escController(AppDbContext context)
        {
            conEsc = context;
        }

        [HttpGet]
        public ActionResult Get()
        {
            return Ok(conEsc.alumno.ToList());
        }

        [HttpGet("{id}")]
        public ActionResult Get(int id)
        {
            var alumno = conEsc.alumno.FirstOrDefault(a => a.Matricula == id);
            if (alumno == null)
            {
                return NotFound();
            }
            return Ok(alumno);
        }

        [HttpPost]
        public ActionResult Post(Alumno alumno)
        {
            try
            {
                conEsc.alumno.Add(alumno);
                conEsc.SaveChanges();
                return Ok(alumno);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.ToString());
            }
        }

        [HttpPut("{id}")]
        public ActionResult Put(int id, Alumno alumno)
        {
            if (id != alumno.Matricula)
            {
                return BadRequest();
            }
            conEsc.Entry(alumno).State = EntityState.Modified;
            conEsc.SaveChanges();
            return Ok();
        }

        [HttpDelete("{id}")]
        public ActionResult Delete(int id)
        {
            var alumno = conEsc.alumno.FirstOrDefault(a => a.Matricula == id);
            if (alumno == null)
            {
                return NotFound();
            }
            conEsc.alumno.Remove(alumno);
            conEsc.SaveChanges();
            return Ok();
        } 
    }
}
