---
sidebar_position: 0
title: Overview
---

The process behind all library releases is defined in a couple of steps and will happen for likely
all versions regardless of patch, minor or major:

1. [Discovery](discovery) - this step walks side by side with the addon development and it is based in a 
text document listing what must be implemented in the library to support addon demands.
1. [Versioning](versioning) - while the discovery document is written, a version must be determined to
be later tagged in the library repository.
1. [Implementation](implementation) - the implementation of what's described in the discovery document starts
when it's considered finished, i.e., when the version is determined.
1. [Deployment](deployment) - finally, when the implementation covers all the discovery document sections, the
deployment will tag a new release so addons can import it and make use of what's available in the new version.