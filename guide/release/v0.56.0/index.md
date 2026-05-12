# v0.56.0

## Features

For tasks with estimates or work on, a chart shows the burn-up in comparison with the estimates.

In the member list screen, active members are shown first and pagination is enabled.

The rods representing estimated values in the "Projects > Charts > Completed and remaining work" are now rendered as "planned" according to IBCS.

Tasks have an owner similar to [code ownership](https://en.wikipedia.org/wiki/Code_ownership). Currently, the owner is algorithmically assigned as described in the chapter about [ownership](../../user/ownership.md).

During transfers, unknown users can now be added automatically. To achiebe this, set the fallback of user mappings to "match or create". This initially attempts to match an external user same as a fallback of "match". However, if no match is found, it creates an inactive user that cannot log in derived from the interfaction of the external user.

Task details of finished tasks now have a green checkmark in the heading.

In the sidebar of task details, assignees with long names are rendered without visual mess.

The member list screen has a search bar and supports pagination.

## Improvements

Task progress bars show their percentage without the fractional part to reduce clutter.

The ordering of active and recent tasks has been modified to show the most recently worked on tasks first, and then order by time of creation.
