---
title: PassFort Integration API Reference

language_tabs:
  - python: Python
  - javascript: NodeJS

toc_footers:
  - '&copy; 2020 PassFort'
  - '<a href="https://developer.passfort.com">PassFort Developer Hub</a>'
  - '<a href="https://help.passfort.com/category/k84bc464f5-developer-documentation">PassFort Developer Help Center</a>'

search: true
---
# Introduction

The PassFort Integration API allows you to easily connect new data sources
(integrations) to PassFort by creating a JSON web service which conforms to
the specifications outlined in this document.

**Please ignore all references to kittens in this document.**

## Using this documentation

As the Integration API is not called but served by integrations, the endpoints
documented here are ones that your integration should implement.

Code samples are given in the dark area to the right, and will generally take
the form of abbreviated route handlers for the functionality being described.
For the Python examples, [Flask 1.0][flask-docs]
will be used as the implementation example, and [Express 4][express-docs] will  
be used for the NodeJS examples.

# Technical Requirements

Your integration _must_ be served over HTTPS; integrations are not permitted to
be served over unencrypted HTTP connections. Additionally, the connection must
be using TLS 1.2 or above.

# Authentication

In order to protect the integrity and confidentiality of personal information
and to ensure your integration is only utilised by PassFort, all requests _and_
responses are authenticated using the
[HTTP signatures draft standard, version 12][http-signatures-draft-12].
Several usable implementations of the standard can be found on this
[tracker of HTTP Signatures implementations][signatures-impl-thread] maintained
by the spec authors.

When implementing an integration, you will be provided with a Base64-encoded
secret key to use to sign your responses and verify PassFort requests; the key
ID to use should be the first 8 characters of this key. The only supported
algorithm is `hmac-sha256`, and the only supported Digest is `SHA-256`.

You must sign and verify at least `request-target` (the verb and full path of
the initial request), and the `Digest`, `Date` and `Host` headers.

<aside class="warning">
 You <strong>must</strong> verify signatures in incoming requests - signing
 your responses alone is not adequate. The validation suite will fail
 integrations that do not correctly verify the signature of incoming requests.
</aside>

[flask-docs]: https://flask.palletsprojects.com/en/1.0.x/
[express-docs]: https://expressjs.com/en/4x/api.html
[http-signatures-draft-12]:
  https://tools.ietf.org/html/draft-cavage-http-signatures-12
[signatures-impl-thread]: https://github.com/w3c-dvcg/http-signatures/issues/1
