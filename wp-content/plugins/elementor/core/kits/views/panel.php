<script type="text/template" id="tmpl-elementor-kit-panel">
	<main id="elementor-kit__panel-content__wrapper" class="elementor-panel-content-wrapper"><\/main>
</script>

<script type="text/template" id="tmpl-elementor-kit-panel-content">
	<div id="elementor-kit-panel-content-controls">
	<#
	const tabConfig = $e.components.get( 'panel/global' ).getActiveTabConfig();
	if ( tabConfig.helpUrl ) { #>
	<div id="elementor-panel__editor__help">
		<a id="elementor-panel__editor__help__link" href="{{ tabConfig.helpUrl }}" target="_blank">
			<br />
<b>Fatal error:  Uncaught Error: Call to undefined function esc_html__() in C:\xampp\htdocs\hotelbooking\wp-content\plugins\elementor\core\kits\views\panel.php:12
Stack trace:
#0 {main}
  thrown in <b>C:\xampp\htdocs\hotelbooking\wp-content\plugins\elementor\core\kits\views\panel.php on line <b>12<br />
</script>