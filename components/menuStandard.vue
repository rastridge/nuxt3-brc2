<template>
	<nav class="fixed-top">
		<Menubar :model="items" class="p-menubar">
			<template #start>
				<img alt="logo" src="/trucklogo.png" height="40" /> </template
		></Menubar>
	</nav>
</template>

<script setup>
	import Menubar from 'primevue/menubar'

	const {
		data: menu_data,
		pending,
		error,
		refresh,
	} = await useFetch(`/content/custommenuitems`, {
		method: 'get',
		headers: {
			authorization: 'not-needed',
		},
	})

	const custommenuitems = []

	menu_data.value.forEach((element) => {
		custommenuitems.push({
			label: `${element.content_name}`,
			icon: 'pi pi-fw pi-bookmark',
			to: `/content/${element.content_id}`,
		})
	})

	const items = [
		{
			label: 'Home',
			// icon: 'pi pi-fw pi-bookmark',
			to: '/',
		},
		{
			label: 'News',
			// icon: 'pi pi-fw pi-bookmark',
			to: '/news',
		},
		{
			label: 'About',
			icon: 'pi pi-fw pi-bookmark',
			items: custommenuitems,
		},
		{
			label: 'Examples',
			icon: 'pi pi-fw pi-bookmark',
			items: [
				{
					label: 'Autocomplete',
					icon: 'pi pi-fw pi-bookmark',
					to: '/examples/autocomplete',
				},

				{
					label: 'Datepicker',
					icon: 'pi pi-fw pi-bookmark',
					to: '/examples/datepicker',
				},
				{
					label: 'Editor',
					icon: 'pi pi-fw pi-bookmark',
					to: '/examples/editor',
				},
			],
		},
		{
			label: 'Register',
			icon: 'pi pi-fw pi-user',
			to: '/register',
		},
		{
			label: 'Login',
			icon: 'pi pi-fw pi-user',
			to: '/loginpage',
		},
	]
</script>

<style scoped>
	.p-menubar {
		justify-content: center;
		padding: 1rem;
		font-size: 1.5rem;
	}
	.p-menubar {
		background-color: rgb(3, 205, 97);
	}
</style>
