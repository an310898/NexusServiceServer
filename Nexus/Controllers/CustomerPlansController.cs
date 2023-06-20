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
    public class CustomerPlansController : ControllerBase
    {
        private readonly NexusContext _context;

        public CustomerPlansController(NexusContext context)
        {
            _context = context;
        }

        // GET: api/CustomerPlans
        [HttpGet]
        public async Task<ActionResult<IEnumerable<CustomerPlan>>> GetCustomerPlans()
        {
          if (_context.CustomerPlans == null)
          {
              return NotFound();
          }
            return await _context.CustomerPlans
                .Include(x=>x.Customer)
                .Include(x=>x.PlanDetail)
                .Include(x=>x.Product)
                .ToListAsync();
        }

        // GET: api/CustomerPlans/5
        [HttpGet("{id}")]
        public async Task<ActionResult<CustomerPlan>> GetCustomerPlan(int id)
        {
          if (_context.CustomerPlans == null)
          {
              return NotFound();
          }
            var customerPlan = await _context.CustomerPlans.FindAsync(id);

            if (customerPlan == null)
            {
                return NotFound();
            }

            return customerPlan;
        }

        // PUT: api/CustomerPlans/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutCustomerPlan(int id, CustomerPlan customerPlan)
        {
            if (id != customerPlan.Id)
            {
                return BadRequest();
            }

            _context.Entry(customerPlan).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CustomerPlanExists(id))
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

        // POST: api/CustomerPlans
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<CustomerPlan>> PostCustomerPlan(CustomerPlan customerPlan)
        {
          if (_context.CustomerPlans == null)
          {
              return Problem("Entity set 'NexusContext.CustomerPlans'  is null.");
          }
            _context.CustomerPlans.Add(customerPlan);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetCustomerPlan", new { id = customerPlan.Id }, customerPlan);
        }

        // DELETE: api/CustomerPlans/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCustomerPlan(int id)
        {
            if (_context.CustomerPlans == null)
            {
                return NotFound();
            }
            var customerPlan = await _context.CustomerPlans.FindAsync(id);
            if (customerPlan == null)
            {
                return NotFound();
            }

            _context.CustomerPlans.Remove(customerPlan);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool CustomerPlanExists(int id)
        {
            return (_context.CustomerPlans?.Any(e => e.Id == id)).GetValueOrDefault();
        }
    }
}
