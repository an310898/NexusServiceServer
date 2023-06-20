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
    public class PlansDetailsController : ControllerBase
    {
        private readonly NexusContext _context;

        public PlansDetailsController(NexusContext context)
        {
            _context = context;
        }

        // GET: api/PlansDetails
        [HttpGet]
        public async Task<ActionResult<IEnumerable<PlansDetail>>> GetPlansDetails()
        {
          if (_context.PlansDetails == null)
          {
              return NotFound();
          }
            return await _context.PlansDetails.ToListAsync();
        }

        // GET: api/PlansDetails/5
        [HttpGet("{id}")]
        public async Task<ActionResult<PlansDetail>> GetPlansDetail(int id)
        {
          if (_context.PlansDetails == null)
          {
              return NotFound();
          }
            var plansDetail = await _context.PlansDetails.FindAsync(id);

            if (plansDetail == null)
            {
                return NotFound();
            }

            return plansDetail;
        }

        // PUT: api/PlansDetails/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutPlansDetail(int id, PlansDetail plansDetail)
        {
            if (id != plansDetail.Id)
            {
                return BadRequest();
            }

            _context.Entry(plansDetail).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!PlansDetailExists(id))
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

        // POST: api/PlansDetails
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<PlansDetail>> PostPlansDetail(PlansDetail plansDetail)
        {
          if (_context.PlansDetails == null)
          {
              return Problem("Entity set 'NexusContext.PlansDetails'  is null.");
          }
            _context.PlansDetails.Add(plansDetail);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetPlansDetail", new { id = plansDetail.Id }, plansDetail);
        }

        // DELETE: api/PlansDetails/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeletePlansDetail(int id)
        {
            if (_context.PlansDetails == null)
            {
                return NotFound();
            }
            var plansDetail = await _context.PlansDetails.FindAsync(id);
            if (plansDetail == null)
            {
                return NotFound();
            }

            _context.PlansDetails.Remove(plansDetail);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool PlansDetailExists(int id)
        {
            return (_context.PlansDetails?.Any(e => e.Id == id)).GetValueOrDefault();
        }
    }
}
