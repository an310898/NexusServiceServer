using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Nexus.Models;

namespace Nexus.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PlansOptionsController : ControllerBase
    {
        private readonly NexusContext _context;

        public PlansOptionsController(NexusContext context)
        {
            _context = context;
        }

        // GET: api/PlansOptions
        [HttpGet]
        public async Task<ActionResult<IEnumerable<PlansOption>>> GetPlansOptions()
        {
          if (_context.PlansOptions == null)
          {
              return NotFound();
          }
            return await _context.PlansOptions.ToListAsync();
        }

        // GET: api/PlansOptions/5
        [HttpGet("{id}")]
        public async Task<ActionResult<PlansOption>> GetPlansOption(int id)
        {
          if (_context.PlansOptions == null)
          {
              return NotFound();
          }
            var plansOption = await _context.PlansOptions.FindAsync(id);

            if (plansOption == null)
            {
                return NotFound();
            }

            return plansOption;
        }

        // PUT: api/PlansOptions/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutPlansOption(int id, PlansOption plansOption)
        {
            if (id != plansOption.Id)
            {
                return BadRequest();
            }

            _context.Entry(plansOption).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!PlansOptionExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/PlansOptions
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<PlansOption>> PostPlansOption(PlansOption plansOption)
        {
          if (_context.PlansOptions == null)
          {
              return Problem("Entity set 'NexusContext.PlansOptions'  is null.");
          }
            _context.PlansOptions.Add(plansOption);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetPlansOption", new { id = plansOption.Id }, plansOption);
        }

        // DELETE: api/PlansOptions/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeletePlansOption(int id)
        {
            if (_context.PlansOptions == null)
            {
                return NotFound();
            }
            var plansOption = await _context.PlansOptions.FindAsync(id);
            if (plansOption == null)
            {
                return NotFound();
            }

            _context.PlansOptions.Remove(plansOption);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool PlansOptionExists(int id)
        {
            return (_context.PlansOptions?.Any(e => e.Id == id)).GetValueOrDefault();
        }
    }
}
