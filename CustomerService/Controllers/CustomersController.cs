using CustomerService.Data;
using CustomerService.DTOs;
using CustomerService.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace CustomerService.Controllers;

[ApiController]
[Route("api/[controller]")]
public class CustomersController : ControllerBase
{
    private readonly AppDbContext _dbContext;

    public CustomersController(AppDbContext dbContext)
    {
        _dbContext = dbContext;
    }

    [HttpGet]
    public async Task<ActionResult<IEnumerable<CustomerReadDto>>> GetAll()
    {
        var customers = await _dbContext.Customers
            .OrderBy(c => c.Id)
            .Select(c => new CustomerReadDto(
                c.Id,
                c.FirstName,
                c.LastName,
                c.Email,
                c.PhoneNumber,
                c.DateOfBirth,
                c.CreatedAtUtc))
            .ToListAsync();
        return Ok(customers);
    }

    [HttpGet("{id:int}")]
    public async Task<ActionResult<CustomerReadDto>> GetById(int id)
    {
        var c = await _dbContext.Customers.FindAsync(id);
        if (c == null) return NotFound();
        return Ok(new CustomerReadDto(c.Id, c.FirstName, c.LastName, c.Email, c.PhoneNumber, c.DateOfBirth, c.CreatedAtUtc));
    }

    [HttpPost]
    public async Task<ActionResult<CustomerReadDto>> Create(CustomerCreateDto dto)
    {
        var exists = await _dbContext.Customers.AnyAsync(x => x.Email == dto.Email);
        if (exists) return Conflict(new { message = "Email already exists" });

        var entity = new Customer
        {
            FirstName = dto.FirstName,
            LastName = dto.LastName,
            Email = dto.Email,
            PhoneNumber = dto.PhoneNumber ?? string.Empty,
            DateOfBirth = dto.DateOfBirth ?? default,
            CreatedAtUtc = DateTime.UtcNow
        };
        _dbContext.Customers.Add(entity);
        await _dbContext.SaveChangesAsync();
        var read = new CustomerReadDto(entity.Id, entity.FirstName, entity.LastName, entity.Email, entity.PhoneNumber, entity.DateOfBirth, entity.CreatedAtUtc);
        return CreatedAtAction(nameof(GetById), new { id = entity.Id }, read);
    }

    [HttpPut("{id:int}")]
    public async Task<ActionResult<CustomerReadDto>> Update(int id, CustomerUpdateDto dto)
    {
        var entity = await _dbContext.Customers.FindAsync(id);
        if (entity == null) return NotFound();

        if (!string.Equals(entity.Email, dto.Email, StringComparison.OrdinalIgnoreCase))
        {
            var emailTaken = await _dbContext.Customers.AnyAsync(x => x.Email == dto.Email && x.Id != id);
            if (emailTaken) return Conflict(new { message = "Email already exists" });
        }

        entity.FirstName = dto.FirstName;
        entity.LastName = dto.LastName;
        entity.Email = dto.Email;
        entity.PhoneNumber = dto.PhoneNumber ?? string.Empty;
        entity.DateOfBirth = dto.DateOfBirth ?? default;

        await _dbContext.SaveChangesAsync();
        var read = new CustomerReadDto(entity.Id, entity.FirstName, entity.LastName, entity.Email, entity.PhoneNumber, entity.DateOfBirth, entity.CreatedAtUtc);
        return Ok(read);
    }

    [HttpDelete("{id:int}")]
    public async Task<IActionResult> Delete(int id)
    {
        var entity = await _dbContext.Customers.FindAsync(id);
        if (entity == null) return NotFound();
        _dbContext.Customers.Remove(entity);
        await _dbContext.SaveChangesAsync();
        return NoContent();
    }
}

