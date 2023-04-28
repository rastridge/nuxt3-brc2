<template>
	<NuxtLayout>
		<NuxtPage />
	</NuxtLayout>
</template>

<style>
	.page-enter-active,
	.page-leave-active {
		transition: all 0.2s;
	}
	.page-enter-from,
	.page-leave-to {
		opacity: 0;
		filter: blur(1rem);
	}

	/* 	.page-slide-enter-active,
	.page-slide-leave-active {
		position: absolute;
		transition: all 0.85s ease;
	}

	.page-slide-enter-from {
		left: -100%;
	}

	.page-slide-enter-to {
		left: 0%;
	}

	.page-slide-leave-from {
		transform: scale(1);
	}

	.page-slide-leave-to {
		transform: scale(0.8);
	}
 */
</style>
