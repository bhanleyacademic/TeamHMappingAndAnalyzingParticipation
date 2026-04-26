import type { MenuItemType } from '@/types/menu';

/** Base menu items available to all authenticated users. */
export const BASE_MENU_ITEMS: MenuItemType[] = [
    {
        key: 'menu',
        label: 'MENU',
        isTitle: true,
    },
    {
        key: 'dashboard',
        icon: 'solar:home-2-broken',
        label: 'Dashboard',
        route: { name: 'dashboards.index' },
    },
    {
        key: 'analysis',
        label: 'ANALYSIS',
        isTitle: true,
    },
    {
        key: 'analysis-datasets',
        icon: 'solar:server-square-broken',
        label: 'My Datasets',
        route: { name: 'analysis.datasets' },
    },
    {
        key: 'analysis-upload',
        icon: 'solar:upload-broken',
        label: 'Upload Dataset',
        route: { name: 'analysis.upload' },
    },
];

/** Admin-only menu items appended when user.role === 'admin'. */
export const ADMIN_MENU_ITEMS: MenuItemType[] = [
    {
        key: 'admin',
        label: 'ADMIN',
        isTitle: true,
    },
    {
        key: 'admin-users',
        icon: 'solar:users-group-rounded-broken',
        label: 'User Management',
        route: { name: 'admin.users' },
    },
];
