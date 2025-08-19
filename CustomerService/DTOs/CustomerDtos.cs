namespace CustomerService.DTOs;

public record CustomerCreateDto(
    string FirstName,
    string LastName,
    string Email,
    string? PhoneNumber,
    DateOnly? DateOfBirth
);

public record CustomerUpdateDto(
    string FirstName,
    string LastName,
    string Email,
    string? PhoneNumber,
    DateOnly? DateOfBirth
);

public record CustomerReadDto(
    int Id,
    string FirstName,
    string LastName,
    string Email,
    string? PhoneNumber,
    DateOnly? DateOfBirth,
    DateTime CreatedAtUtc
);

