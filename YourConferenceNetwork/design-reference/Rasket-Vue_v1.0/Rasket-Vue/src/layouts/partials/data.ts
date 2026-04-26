import type { NotificationType } from '@/layouts/partials/types'
import type { MenuItemType } from '@/types/menu'

export const notifications: NotificationType[] = []

export const profileMenuItems: MenuItemType[] = [
  {
    key: 'subscription',
    label: 'Subscription',
    icon: 'bx-wallet',
    route: { name: 'billing.plans' }
  }
]
