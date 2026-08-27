from pathlib import Path

from mkdocs.config import base, config_options
from mkdocs.exceptions import PluginError
from mkdocs.plugins import BasePlugin
from mkdocs.structure.files import File


class FetchPathConfig(base.Config):
    config_scheme = (
        ("source", config_options.Type(str)),
        ("destination", config_options.Type(str)),
    )


class FetchFilesPlugin(BasePlugin):
    config_scheme = (
        (
            "paths",
            config_options.ListOfItems(
                config_options.SubConfig(FetchPathConfig)
            ),
        ),
    )

    def on_files(self, files, config):
        for mapping in self.config["paths"]:
            source = Path(mapping["source"])
            destination = Path(mapping["destination"])

            if source.is_file():
                source_files = [
                    (source, destination),
                ]

            elif source.is_dir():
                source_files = [
                    (
                        path,
                        destination / path.relative_to(source),
                    )
                    for path in source.rglob("*")
                    if path.is_file()
                ]

            else:
                raise PluginError(
                    f"Source does not exist: {source}"
                )

            for source_path, destination_path in source_files:
                src_uri = destination_path.as_posix()

                if files.get_file_from_path(src_uri) is not None:
                    raise PluginError(
                        f"Generated file conflicts with existing file: "
                        f"{src_uri}"
                    )

                files.append(
                    File.generated(
                        config,
                        src_uri,
                        abs_src_path=str(source_path),
                    )
                )

        return files
