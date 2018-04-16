backend "file" {
        path = "/var/lib/vault"
}

listener "tcp" {
        tls_disable = 0
        tls_cert_file = "/etc/tls/certs/example.com.pem"
        tls_key_file = "/etc/tls/private/example.com.key"
        address = "example.com:8200"

}

ui = true
