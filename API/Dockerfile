# Use an official Golang runtime as a parent image
FROM golang:1.17 as build

# Set the working directory inside the container
WORKDIR /app

# Copy the local package files to the container's workspace
COPY go.mod .
COPY go.sum .

# Download and install any required dependencies
RUN go mod download

# Copy the rest of your application source code
COPY . .

# Build the Go application
RUN go build -o main

# Start a new stage and use a lightweight base image
FROM alpine:latest

# Copy the binary from the previous stage
COPY --from=build /app/main /app/main

# Expose the port your application will listen on
EXPOSE 8080

# Command to run your application
CMD ["/app/main"]
