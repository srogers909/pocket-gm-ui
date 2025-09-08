/// Utility class for handling country flags based on player birth information
class FlagUtils {
  static const Map<String, String> _countryFlags = {
    'USA': '🇺🇸',
    'Canada': '🇨🇦',
    'England': '🇬🇧',
    'Australia': '🇦🇺',
    'Germany': '🇩🇪',
    'Japan': '🇯🇵',
    'Mexico': '🇲🇽'
  };

  /// Returns the appropriate flag emoji based on birth location string
  static String getFlagForLocation(String birthInfo) {
    final location = birthInfo.toLowerCase();
    
    // Check for US states (GA, TX, IL, CA, FL, MI, PA, AZ, NC)
    if (location.contains(', ga') || 
        location.contains(', tx') || 
        location.contains(', il') || 
        location.contains(', ca') || 
        location.contains(', fl') || 
        location.contains(', mi') || 
        location.contains(', pa') || 
        location.contains(', az') || 
        location.contains(', nc')) {
      return _countryFlags['USA'] ?? '';
    }
    
    // Check for Canadian provinces (ON, BC, QC, AB)
    if (location.contains(', on') || 
        location.contains(', bc') || 
        location.contains(', qc') || 
        location.contains(', ab')) {
      return _countryFlags['Canada'] ?? '';
    }
    
    // Check for specific countries
    if (location.contains('england')) {
      return _countryFlags['England'] ?? '';
    }
    if (location.contains('australia')) {
      return _countryFlags['Australia'] ?? '';
    }
    if (location.contains('germany')) {
      return _countryFlags['Germany'] ?? '';
    }
    if (location.contains('japan')) {
      return _countryFlags['Japan'] ?? '';
    }
    if (location.contains('mexico')) {
      return _countryFlags['Mexico'] ?? '';
    }
    
    // Default to empty string if no match found
    return '';
  }
}
