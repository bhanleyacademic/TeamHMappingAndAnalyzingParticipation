export type User = {
  id?: string | number
  email?: string
  username?: string
  firstName?: string
  lastName?: string
  role?: string
}

export type AuthSession = {
  user: User
  accessToken: string
  refreshToken: string
  /** Present when an admin is impersonating this user */
  impersonatorId?: number
  impersonatorEmail?: string
}
