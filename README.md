\# Readers' Haven Public Library





\## Build locally

npm ci

npm run build        # output in dist/



\## Run with Docker

docker image build -t saitama2/readers-haven:dev .

docker container run -d --name haven-local -p 8080:80 saitama2/readers-haven:dev

\# open http://localhost:8080



\## Branching

\- main: production

\- develop: integration

\- feature/<page-name>: one per member

\- release/v2.0: final testing



\## Team

| Page | Owner |

|------|-------|

| index.html | TL |

| collections.html | Member 1 |

| membership.html | Member 2 |

| services.html | Member 3 |

| contact.html | Member 4 |

