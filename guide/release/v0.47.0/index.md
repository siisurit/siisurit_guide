# v0.47.0

## Simplified sign-in

The sign-in dialog now stores the credentials using the password manager of the web browser or system. Consequently, the rather complex screens to manage multiple accounts are gone.

## Improved tasks screen

The former "Misestimates" screen has been changed to "Tasks" and now by default shows all tasks the member has access to. To drill down on particularly interesting tasks, the member can provide search terms or filters.

The current set of filters is still limited, more will come in the future.

## Improved tooltips

The tooltips for charts about contributions during a certain period now list the rods that contribute to the chart instead of just showing the sum.

## Fixed empty relations in admin site

On the admin site, certain models would refuse to be edited and saved with empty relations. For example, a task without labels. This has been fixed.

## Optimizations

- Switching between tabs in detail screens for projects and tasks is more fluent now and does not require a reload of the data.
- Queries related to tasks have been optimized. This is an ongoing process, more queries will follow.
