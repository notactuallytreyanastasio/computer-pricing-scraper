# A simple pricing scraper

This has no dependencies outside typical rails stuff.

It simply uses `net/http` to grab some specific pages from the EVGA website and extracts pricing information.
It is met to be run daily to monitor pricing of parts in this supply chain.
On the deployed version, I have a job that runs a scrape once a day to monitor this.

It does nothing 'the rails way' and is built as a one-off hack but it does the job its intended to.

I am going to add some ascii graphing to the pricing history, and potentially add monitors from another site.
Who knows, its a project I am doing for a family member with an interest in this.

As such, if you stumble upon this randomly, please dont open any issues or PRs, I plan on not engaging anyone but the single end user I built it for.
