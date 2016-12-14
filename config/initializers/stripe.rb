Rails.configuration.stripe = {
    publishable_key: 'pk_test_FqalKj6XWdopT0oWksb2Ackb',
    secret_key: 'sk_test_pTsgY55Ovt9ubnSusySyBcTT'
}
Stripe.api_key = Rails.configuration.stripe[:secret_key]