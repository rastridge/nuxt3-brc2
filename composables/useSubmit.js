import { useAuthStore } from '~~/stores/authStore'
const auth = useAuthStore()

export default function useSubmit() {
	const onSubmitEdit = function (app, form_state) {
		// saving.value = true
		const { data, pending, error } = useLazyFetch(`/${app}/editone`, {
			method: 'post',
			body: form_state,
			headers: {
				authorization: auth.user.token,
			},
		})
		// saving.value = pending.value
		if (error.value) {
			throw createError({
				...error.value,
				statusMessage: `Could not submit data to /${app}/editone`,
			})
		}
		// } else {
		// 	navigateTo(`/admin/${app}`)
		// }
	}
	const onSubmitAdd = function (app, form_state) {
		// saving.value = true
		const { data, pending, error } = useLazyFetch(`/${app}/addone`, {
			method: 'post',
			body: form_state,
			headers: {
				authorization: auth.user.token,
			},
		})
		// saving.value = pending.value
		if (error.value) {
			throw createError({
				...error.value,
				statusMessage: `Could not submit data to /${app}/addone`,
			})
		}
		// } else {
		// 	navigateTo(`/admin/${app}`)
		// }
	}
	return { onSubmitEdit, onSubmitAdd }
}
