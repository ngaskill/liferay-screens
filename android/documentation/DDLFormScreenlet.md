# DDLFormScreenlet for Android

## Important Note

*This product is under heavy development and its features aren't ready for use in production. It's being made public only to allow developers to preview the technology.*

## Requirements

- Android SDK 4.0 (API Level 14) and above
- Liferay Portal 6.2 CE or EE
- Mobile Widgets plugin

## Compatibility

- Android SDK 4.0 (API Level 14) and above

## Features

The `DDLFormScreenlet` shows a set of fields that can be filled in by the user. Initial or existing values can be shown in the fields. Fields of the following data types are supported:

- *Boolean*: A two state value typically represented by a checkbox.
- *Date*: A formatted date value. The format depends on the device's current locale.
- *Decimal, Integer, and Number*: A numeric value.
- *Documents & Media*: A file stored on the device. It can be uploaded to a specific portal repository.
- *Radio*: A set of options to choose from. A single option must be chosen. 
- *Select*: A dropdown list of options to choose from. A single option must be chosen.
- *Text*: A single line of text.
- *Text Area*: Multiple lines of text.

The `DDLFormScreenlet` also supports the following features:

- Stored records can support a specific workflow.
- A Submit button can be shown at the end of the form.
- Required values and validation for fields can be used. 
- Users can traverse the form fields from the keyboard.
- Supports i18n in record values and labels.

There are also a few limitations that you should be aware of when using `DDLFormScreenlet`. They are listed here:

- Nested fields in the data definition aren't supported.
- Selection of multiple items in the Radio and Select data types isn't supported.

## Module

- DDL

## Views

The Default view uses a standard vertical `ScrollView` to show a scrollable list of fields. Other views may use different components, such as `ViewPager` or others, to show the fields. You can find a sample of this implementation in the `DDLFormScreenletPagerView` class.

![The `DDLForm` screenlet's Default and Material viewsets.](images/ddlform.png)

### Editor Types

Each field defines an editor type. You must define each editor type's layout by using the following attributes:

  - `checkboxFieldLayoutId`: The layout to use for Boolean fields.
  - `dateFieldLayoutId`: The layout to use for Date fields.
  - `numberFieldLayoutId`: The layout to use for Number, Decimal, or Integer fields.
  - `radioFieldLayoutId`: The layout to use for Radio fields.
  - `selectFieldLayoutId`: The layout to use for Select fields.
  - `textFieldLayoutId`: The layout to use for Text fields.
  - `textAreaFieldLayoutId`: The layout to use for Text Box fields.
  - `textDocumentFieldLayoutId`: The layout to use for Documents & Media fields.

If you don't define the editor type's layout in the attributes of `DDLFormScreenlet`, the default layout `ddlfield_xxx_default` is used, where `xxx` is the name of the editor type. It's important to note that you can change the layout used with any editor type at any point.

### Custom Editors

What if you want to have a unique appearance for one specific field? No problem! You can customize your field's editor view by calling the screenlet's `setCustomFieldLayoutId(fieldName, layoutId)` method, where the first parameter is the name of the field customize and the second parameter is the layout to use. You can also easily create custom editor views. For examples of this, see the files `ddlfield_custom_rating_number.xml` and `CustomRatingNumberView.java`.

## Activity Configuration

The `DDLForm Screenlet` needs the following user permissions:

	```xml
	<uses-permission android:name="android.permission.CAMERA"/>
	<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
	```

Both are used by the Documents and Media fields to take a picture/video and store it locally before uploading it to the portal. The Documents and Media fields also need to override the `onActivityResult` method to receive the picture/video information. Here's an example implementation:

	```java
		@Override
		protected void onActivityResult(int requestCode, int resultCode, Intent data) {
			super.onActivityResult(requestCode, resultCode, data);
	
			_screenlet.startUploadByPosition(requestCode);
		}
	```
	
## Portal Configuration

Before using `DDLFormScreenlet`, you should make sure that Dynamic Data Lists and Data Types are configured properly in the portal. Refer to the [Defining Data Types](https://dev.liferay.com/discover/portal/-/knowledge_base/6-2/building-a-list-platform-in-liferay-and-defining-data-) and [Creating Data Lists](https://dev.liferay.com/discover/portal/-/knowledge_base/6-2/creating-data-lists) sections of the User Guide for more details. If Workflow is required, it must also be configured. See the [Using Workflow](https://dev.liferay.com/discover/portal/-/knowledge_base/6-2/using-workflow) section of the User Guide for details.

### Permissions

To use `DDLFormScreenlet` to add new records, you must grant the Add Record permission in the Dynamic Data List:

![The Add Record permission.](../../ios/Documentation/Images/portal-permission-record-add.png)

If you want to use `DDLFormScreenlet` to view or edit record values, you must also grant the View and Update permissions, respectively:

![The permissions for viewing and editing records.](../../ios/Documentation/Images/portal-permission-record-edit.png)

Also, if your form includes at least one Documents and Media field, you must grant permissions in the target repository and folder. For more details, see the `repositoryId` and `folderId` attributes below.

![The permission for adding a folder.](../../ios/Documentation/Images/portal-permission-folder-add.png)

For more details, see the User Guide sections [Defining Data Types](https://dev.liferay.com/discover/portal/-/knowledge_base/6-2/building-a-list-platform-in-liferay-and-defining-data-), [Creating Data Lists](https://dev.liferay.com/discover/portal/-/knowledge_base/6-2/creating-data-lists), and [Using Workflow](https://dev.liferay.com/discover/portal/-/knowledge_base/6-2/using-workflow).

## Required Attributes

- `layoutId`
- `structureId`
- `recordSetId`

## Attributes

| Attribute | Data Type | Explanation |
|-----------|-----------|-------------| 
| `layoutId` | `@layout` | The layout to use to show the view. |
| `checkboxFieldLayoutId ` | `@layout` | The layout to use to show the view for Boolean fields. |
| `dateFieldLayoutId` | `@layout` | The layout to use to show the view for Date fields. |
| `numberFieldLayoutId` | `@layout` | The layout to use to show the view for Number, Decimal, and Integer fields. |
| `radioFieldLayoutId` | `@layout` | The layout to use to show the view for Radio fields. |
| `selectFieldLayoutId` | `@layout` | The layout to use to show the view for Select fields. |
| `textFieldLayoutId` | `@layout` | The layout to use to show the view for Text fields. |
| `textAreaFieldLayoutId` | `@layout` | The layout to use to show the view for Text Box fields. |
| `textDocumentFieldLayoutId` | `@layout` | The layout to use to show the view for Documents & Media fields. |
| `structureId` | `number` | The ID of a data definition in your Liferay site. To find the IDs for your data definitions, click *Admin* &rarr; *Content* from the Dockbar. Then click *Dynamic Data Lists* on the left and click the *Manage Data Definitions* button. The ID of each data definition is in the ID column of the table. |
| `groupId` | `number` | The ID of the site (group) where the record is stored. If this value is `0`, the `groupId` specified in `LiferayServerContext` is used. |
| `recordSetId` | `number` | A dynamic data list's ID. To find your dynamic data lists' IDs, click *Admin* &rarr; *Content* from the Dockbar. Then click *Dynamic Data Lists* on the left. Each dynamic data list's ID is in the ID column of the table. |
| `recordId` | `number` | The ID of the record you want to show. You can also allow the record's values to be edited. This ID can be obtained from other methods or delegates. |
| `repositoryId` | `number` | The ID of the Documents and Media repository to upload to. If this value is `0`, the default repository for the site specified by `groupId` is used. |
| `folderId` | `number` | The ID of the folder where Documents and Media files are uploaded. If this value is `0`, the root is used. |
| `filePrefix` | `string` | The prefix to attach to the names of files uploaded to a Documents and Media repository. The upload date followed by the original file name is appended following the prefix. |
| `autoLoad` | `boolean` | Sets whether the form loads when the screenlet is shown. If `recordId` is set, the record value is loaded together with the form definition. The default value is `false`. |
| `autoScrollOnValidation` | `boolean` | Sets whether the form automatically scrolls to the first failed field when validation is used. The default value is `true`. |
| `showSubmitButton` | `boolean` | Sets whether the form shows a submit button at the bottom. If this is set to `false`, you should call the `submitForm()` method. The default value is `true`. |

## Methods

| Method | Return Type | Explanation |
|-----------|-----------|-------------| 
| `loadForm()` | `void` | Starts the request to load the form definition. The form fields are shown when the response is received. |
| `loadRecord()` | `void` | Starts the request to load the record specified by `recordId`. If needed, the form definition also loads. When the response is received, the form fields are shown filled with record values. |
| `load()` | `void` | Starts the request to load the record if `recordId` is specified. Otherwise, the form definition is loaded. |
| `submitForm()` | `void` | Starts the request to submit form values to the dynamic data list specified by `recordSetId`. If the record is new, a new record is added. If `loadRecord` is used to retrieve the record, or the record already exists, its values are updated. Fields are validated prior to the request. If validation fails, the validation errors are shown and the request is terminated. |

## Listener

The `DDLFormScreenlet` delegates some events to an object that implements to the `DDLFormScreenletListener` interface. This interface lets you implement the following methods:

| Method | Explanation |
|-----------|-------------| 
|  <pre>onDDLFormLoaded(Record record)</pre> | Called when the form definition successfully loads.|
|  <pre>onDDLFormRecordLoaded(Record record)</pre> | Called when the form record data successfully loads. |
|  <pre>onDDLFormRecordAdded(Record record)</pre> | Called when the form record is successfully added. |
|  <pre>onDDLFormRecordUpdated(Record record)</pre> | Called when the form record data successfully updates. |
|  <pre>onDDLFormLoadFailed(Exception e)</pre> | Called when an error occurs in the load form definition request.|
|  <pre>onDDLFormRecordLoadFailed(Exception e)</pre> | Called when an error occurs in the load form record request. |
|  <pre>onDDLFormRecordAddFailed(Exception e)</pre> | Called when an error occurs in the request to add a new record. |
|  <pre>onDDLFormUpdateRecordFailed(Exception e)</pre> | Called when an error occurs in the request to update an existing record. |
|  <pre>onDDLFormDocumentUploaded(DocumentField field)</pre> | Called when a specified document field's upload completes. |
|  <pre>onDDLFormDocumentUploadFailed(<br/>        DocumentField field,<br/>        Exception e)</pre> | Called when a specified document field's upload fails. |
