# WebContentDisplayScreenlet for iOS

## Important Note

*This product is under heavy development and its features aren't ready for use in production. It's being made public only to allow developers to preview the technology.*

## Requirements

- Android SDK 4.0 (API Level 14) and above
- Liferay Portal 6.2 CE or EE
- Mobile Widgets plugin

## Compatibility

- Android SDK 4.0 (API Level 14) and above

## Features

The `WebContentDisplayScreenlet` shows web content elements in your app, rendering the web content's inner HTML. The screenlet also supports i18n, rendering contents differently depending on the device's locale.

## Module

- None

## Views

The Default view uses a standard `WebView` to render the HTML.

<!-- PICTURE
![The `WebContentDisplayScreenlet` using the Default theme](Images/webcontent.png) -->

## Portal Configuration

For the `WebContentDisplayScreenlet` to function properly, there should be web content in the Liferay instance your app connects to. For more details on web content, see the [Web Content Management](https://dev.liferay.com/discover/portal/-/knowledge_base/6-2/web-content-management) section of the Liferay User Guide.

## Required Attributes

- `layoutId`
- `articleId`

## Attributes

| Attribute | Data type | Explanation |
|-----------|-----------|-------------| 
| `layoutId` | `@layout` | The layout used to show the view. |
| `groupId` | `number` | The ID of the site (group) where the asset is stored. If this value is `0`, the `groupId` specified in `LiferayServerContext` is used. |
| `articleId` | `string` | The ID of the web content to display. You can find this ID by clicking *Edit* on the web content in the portal. |

## Methods

| Method | Return | Explanation |
|-----------|-----------|-------------| 
| `load()` | `void` | Starts the request to load the web content. The HTML is rendered when the response is received. |

## Listener

The `WebContentDisplayScreenlet` delegates some events to an object that implements the `WebContentDisplayListener` interface. This interface lets you implement the following methods:

| Method | Explanation |
|-----------|-------------| 
|  <pre>onWebContentReceived(<br/>        WebContentDisplayScreenlet source, <br/>        String html)</pre> | Called when the web content's HTML is received. To make some adaptations, the listener may return a modified version of the HTML. The original HTML is rendered if the listener returns `null`. |
|  <pre>onWebContentFailure(<br/>        WebContentDisplayScreenlet source,<br/>        Exception e)</pre> | Called when an error occurs in the process. |
