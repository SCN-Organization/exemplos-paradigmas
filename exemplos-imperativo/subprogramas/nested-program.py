def outer_function(x):
    def inner_function(y):
        return y * 2
    
    result = inner_function(x) + 100
    return result

# Example usage
output = outer_function(5)
print(output)  # Output will be 110
