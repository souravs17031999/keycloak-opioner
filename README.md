# keycloak-opioner
Keycloak deployed instance for Opioner

This centralized IAM (identity and access management) will be used for Opioner based applications.

The cloud instance is now live and deployed on ```Render``` hosting platform.


# Environment Variables for local setup  

- DATABASE_URL
- KC_ADMIN_PASSWORD
- KC_ADMIN_USERNAME
- KC_LOG_LEVEL
- KEYSTORE_SECRET
- QUARKUS_HTTP_ACCESS_LOG_ENABLED
- QUARKUS_HTTP_ACCESS_LOG_PATTERN

# Setup 

- Keycloak is used for Opioner as Identity Broker integrated with various social identity providers (google, facebook etc..).  
- It's consumed by Opioner front-end gateway front channel communication and Authorization code flow is triggered with Keycloak and back channel communication is handled by public client.   
