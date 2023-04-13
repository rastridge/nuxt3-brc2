import { useAuthStore } from '~~/stores/authStore'
const auth = useAuthStore()

export default function useFetchAll() {
	const getAll = async (app) => {
		const { data, error, pending } = await useFetch(`/${app}/getall`, {
			method: 'get',
			headers: {
				authorization: auth.user.token,
				// authorization: 'not-needed',
			},
		})
		if (error.value) {
			throw createError({
				...error.value,
				statusMessage: `Could not get data from /${app}/getall`,
			})
		}
		return { data, pending }
	}

	const deleteOne = async (app, id) => {
		const { pending, error, refresh } = await useFetch(`/${app}/${id}`, {
			method: 'DELETE',
			headers: {
				authorization: auth.user.token,
			},
		})
	}

	const changeStatusOne = async (app, { id, status }) => {
		const { pending, error, refresh } = await useFetch(`/${app}/status`, {
			method: 'POST',
			headers: {
				authorization: auth.user.token,
			},
			body: { id, status },
		})
	}
	return {
		getAll,
		deleteOne,
		changeStatusOne,
	}
}
