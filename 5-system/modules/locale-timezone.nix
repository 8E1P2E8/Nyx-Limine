_: {
  time.timeZone = "America/Los_Angeles";
  # Locale configuration for system language and regional settings
  i18n.defaultLocale = "en_US.UTF-8";

  # Additional locale settings for specific regional formats
  i18n.extraLocaleSettings = {
    LC_TIME = "en_US.UTF-8"; # Time/date format (MM/DD/YYYY, 12-hour clock)
    LC_MONETARY = "en_US.UTF-8"; # Currency format ($1,234.56)
    LC_MEASUREMENT = "en_US.UTF-8"; # Measurement system (imperial: inches, pounds, etc.)
  };
}
