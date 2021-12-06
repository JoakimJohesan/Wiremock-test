# From official wiremock image
FROM wiremock/wiremock:2.32.0-alpine
# Copy our stubs into the correct destination for the wiremock image
COPY ./stubs/__files /home/wiremock/__files
COPY ./stubs/mappings /home/wiremock/mappings