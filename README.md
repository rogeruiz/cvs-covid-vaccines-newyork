# CVS Vaccine Text Alert (New York)

This tool sends a text message to the number in `./phone-number.txt` using the
[Textbelt][txtblt] API with a NY CVS location that has available appointments
from the list of locations in `towns.txt`.

This script allows you to repeatably refresh the CVS COVID-19 vaccine page to
see what locations have vaccines available. This does not book a vaccine
appointment. Instead, it sends a text message with the sign-up link and which
location had available bookings. I built this for my senior parents who could
not possible refresh the CVS website consistently or correctly. It's recommended
that you run this on a cronjob that isn't too frequent that it exhausts the API
endpoint or too infrequently where it could possibly miss an available booking.

> This project does not allow users of it to skip the vaccination line. You will
> still need to sign-up manually through the CVS website in order to get a vaccine
> appointment.

## Required files

The following files are required:

- towns.txt
- phone-number.txt
- textbelt-api-key.txt
- api-endpoint.txt
- header-user-agent.txt
- header-referer.txt
- cookie-data.txt

Once you've created those files, you have to populate them with the expected
values. Some of these values can be gleaned from the Inspector Tools > Network
tab when the state is picked on the web page.

### towns.txt

This is a space-delimited list of the towns in NY that you would like to set an
alert for. eg. `WOODSTOCK ALBANY OSWEGO`.

### phone-number.txt

This is a numerical phone number without any other characters. eg. `5551234567`.

### textbelt-api-key.txt

This is an API key provided by [Textbelt][txtblt].

### api-endpoint.txt

This is a URL that CVS uses on modal open to retrieve the JSON result for a
given state.

### header-user-agent.txt

The `User-Agent:` header used by your browser for the initial request.

### header-referer.txt

The `Referer:` header used by your browser for the initial request.

### cookie-data.txt

The `Cookie:` header used by your browser for the initial request.

[txtblt]: https://textbelt.com "Send and receive SMS with a clean, simple API"

## Example config files

If you're more of a visual learner, here's an example of [the necessary config
files in a gist][gist] you can download and populate yourself.

[gist]: https://gist.github.com/rogeruiz/1ce5b4e76b8079870b85ce0571611f7d

## Other states

It's possible to support other states without much modification to the main
logic to the script. The API endpoint should contain a two-letter abbreviation
for the state you are looking for info on. By modifying that value to another
two-letter abbreviation for a given state, the results should change to that
given state. You need to modify the `jq` statement to use the new two-letter
abbreviation for the API call.
