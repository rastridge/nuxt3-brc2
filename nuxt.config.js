// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
	ssr: false,

	app: {
		pageTransition: { name: 'page', mode: 'out-in' },
		head: {
			script: [
				{
					src: 'https://upload-widget.cloudinary.com/global/all.js',
					defer: false,
				},
				/* 				{
					src: 'https://upload-widget.cloudinary.com/2.4.4/widget/runtime.js',
					defer: false,
				},
				{
					src: 'https://upload-widget.cloudinary.com/2.4.4/widget/main.js',
					defer: false,
				},
				{
					src: 'https://cdnjs.cloudflare.com/ajax/libs/rollbar.js/2.11.0/rollbar.min.js',
					defer: false,
				}, */
			],
		},
	},

	modules: ['@formkit/nuxt', '@pinia/nuxt', 'formidable'],
	components: ['~/components/forms', '~/components'],

	dayjs: {
		locales: ['en'],
		defaultLocale: 'en',
		defaultTimeZone: 'America/New_York',
	},

	css: [
		'primevue/resources/themes/saga-blue/theme.css',
		'primevue/resources/primevue.css',
		'primeicons/primeicons.css',
	],

	runtimeConfig: {
		// The private keys which are only
		// available within server-side
		API_SECRET: process.env.API_SECRET,
		DB_HOST: process.env.DB_HOST,
		DB_USER: process.env.DB_USER,
		DB_PASSWORD: process.env.DB_PASSWORD,
		DB_DATABASE: process.env.DB_DATABASE,
		DATABASE_URL: process.env.DATABASE_URL,
		SHADOW_DATABASE_URL: process.env.SHADOW_DATABASE_URL,
		ONSERVER: process.server,
		ONCLIENT: process.client,
		TO: process.env.TO,
		FROM: process.env.FROM,
		FROM_NAME: process.env.FROM_NAME,
		apiSecret: process.env.API_SECRET,
		EE_API_KEY: process.env.EE_API_KEY,
		TWILIO_NUMBER: process.env.TWILIO_NUMBER,
		TWILIO_ACCOUNT_SID: process.env.TWILIO_ACCOUNT_SID,
		TWILIO_AUTH_TOKEN: process.env.TWILIO_AUTH_TOKEN,
		CLOUD_NAME: process.env.CLOUD_NAME,
		CLOUD_API_KEY: process.env.CLOUD_API_KEY,
		CLOUD_API: process.env.CLOUD_API,
		CLOUD_API_SECRET: process.env.CLOUD_API_SECRET,
		CLOUD_UPLOAD_PRESET: process.env.CLOUD_UPLOAD_PRESET,
		MY_MEDIA_API: process.env.MY_MEDIA_API,
		// Keys within public, will be also be
		// exposed to the client-side
		public: {
			FROM: process.env.FROM,
			FROM_NAME: process.env.FROM_NAME,
		},
	},

	build: {
		transpile: ['primevue'],
	},

	nitro: {
		hooks: {
			'dev:reload': () => require('sharp'),
		},
	},

	devtools: false,
})
