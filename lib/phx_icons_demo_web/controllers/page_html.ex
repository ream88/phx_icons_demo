defmodule PhxIconsDemoWeb.PageHTML do
  use PhxIconsDemoWeb, :html

  embed_templates "page_html/*"

  @doc "Version string of a configured provider, git SHAs shortened."
  def version(provider) do
    :phx_icons
    |> Application.fetch_env!(:providers)
    |> Map.fetch!(provider)
    |> elem(1)
    |> String.slice(0, 7)
  end

  def phx_icons_version, do: to_string(Application.spec(:phx_icons, :vsn))

  attr :id, :string, required: true
  attr :name, :string, required: true
  attr :prefix, :string, required: true
  attr :url, :string, required: true
  attr :version, :string, required: true
  slot :description, required: true
  slot :inner_block, required: true

  def provider(assigns) do
    ~H"""
    <section id={@id} class="group mb-10 scroll-mt-20">
      <div class="mb-1 flex flex-wrap items-baseline gap-3">
        <h3 class="font-serif text-xl font-semibold">{@name}</h3>
        <span class="rounded-[5px] border border-ember/25 bg-ember/8 px-2 py-0.5 font-mono text-[11px] font-medium text-ember">
          {@prefix}:*
        </span>
        <span class="rounded-md border border-line bg-white px-2 py-1 font-mono text-xs font-medium text-muted">
          {@version}
        </span>
        <a href={@url} class="ml-auto flex items-center gap-0.5 text-xs font-medium">
          {URI.parse(@url).host} <.icon name="lucide:arrow-up-right" class="size-3" />
        </a>
      </div>
      <p class="mb-3 text-[13.5px] text-body">{render_slot(@description)}</p>
      {render_slot(@inner_block)}
    </section>
    """
  end

  attr :label, :string, required: true
  attr :tint, :boolean, default: true, doc: "tint the icon on hover"
  slot :inner_block, required: true

  def tile(assigns) do
    ~H"""
    <div class={[
      "flex flex-col items-center gap-2 rounded-[10px] border border-line bg-white px-2 pt-[18px] pb-3 text-ink transition-colors",
      @tint && "hover:border-ember hover:text-ember"
    ]}>
      {render_slot(@inner_block)}
      <span class="font-mono text-[10.5px] font-medium text-faint">{@label}</span>
    </div>
    """
  end

  attr :group, :string, required: true
  attr :value, :string, required: true
  attr :checked, :boolean, default: false
  slot :inner_block, required: true

  def pill(assigns) do
    ~H"""
    <label class="cursor-pointer">
      <input type="radio" name={@group} value={@value} checked={@checked} class="peer sr-only" />
      <span class="inline-block rounded-full border border-line bg-white px-3.5 py-[5px] text-xs font-medium text-muted peer-checked:border-ink peer-checked:bg-ink peer-checked:text-paper peer-focus-visible:ring-2 peer-focus-visible:ring-ember">
        {render_slot(@inner_block)}
      </span>
    </label>
    """
  end

  @doc "A one-line, click-to-copy `<.icon>` snippet."
  attr :name, :string, required: true
  attr :class, :string, default: "size-6"

  def snippet(assigns) do
    assigns = assign(assigns, :copy, ~s(<.icon name="#{assigns.name}" class="#{assigns.class}" />))

    ~H"""
    <button
      type="button"
      data-copy={@copy}
      class="flex w-full cursor-pointer items-center rounded-[10px] bg-ink px-[18px] py-3 text-left font-mono text-[13px] leading-relaxed text-code"
    >
      <span>
        &lt;<span class="text-[#F0B27A]">.icon</span> <span class="text-[#9CC4E4]">name</span>=<span class="text-[#B5CEA8]">"{@name}"</span> <span class="text-[#9CC4E4]">class</span>=<span class="text-[#B5CEA8]">"{@class}"</span> /&gt;
      </span>
      <span class="ml-auto flex items-center gap-1 pl-4 text-[11px] whitespace-nowrap text-code-dim">
        <.icon name="lucide:copy" class="size-3" /> copy
      </span>
    </button>
    """
  end

  @doc "A multi-line, click-to-copy code block with a file label."
  attr :file, :string, required: true
  attr :copy, :string, required: true
  slot :inner_block, required: true

  def code(assigns) do
    ~H"""
    <div
      data-copy={@copy}
      class="highlight relative cursor-pointer rounded-[10px] bg-ink px-[18px] py-3.5 font-mono text-[13px] leading-[1.7] text-code [&_pre]:overflow-x-auto"
    >
      <span class="absolute top-2.5 right-3.5 flex items-center gap-1 text-[10px] font-medium text-code-dim">
        {@file} <.icon name="lucide:copy" class="size-3" />
      </span>
      {render_slot(@inner_block)}
    </div>
    """
  end
end
