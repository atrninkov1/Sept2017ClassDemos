<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="GenreAlbumTracks.aspx.cs" Inherits="SamplePages_GenreAlbumTracks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">

    <%--    
    inside a repeater you need a minimum of one ItemTemplate
    other templates include headerTemplate, FooterTemplate, AlternatingItemTemplate, SeparatorTemplate
    
    outer repeater will display the first fields from the DTO class which do not repeat(not in a collection)
    outer repeater will get its data from an ODS
    
    nested repeater will display the collection of the previous repeater
    nested repeater will get its datasource from the collection of the previous DTO level (either a POCO or another DTO)
    --%>

    <%--nested repeater--%>

    <asp:Repeater ID="GenreAlbumTrackList" runat="server" DataSourceID="GenreAlbumTrackListODS"
        ItemType="Chinook.Data.DTOs.GenreDTO">
        <ItemTemplate>
            <h2>Genre: <%# Eval("genre") %></h2>
            <asp:Repeater ID="AlbumTrackList" runat="server" DataSource='<%# Eval("albums")%>' ItemType="Chinook.Data.DTOs.AlbumDTO">
                <ItemTemplate>
                    <h4>Album: <%# string.Format("{0} ({1} Tracks: {2})", Eval("name"), Eval("releaseYear"), Eval("numberOfTracks"))%></h4>

                    <%--ListView--%>

                    <asp:ListView ID="TrackList" runat="server" 
                        ItemType="Chinook.Data.POCOs.TrackPOCO" 
                        DataSource='<%# Item.tracks %>'>
                        <LayoutTemplate>
                            <table>
                                <tr>
                                    <th><asp:Label ID="Label1" runat="server" Text="Song"
                                        Width="600px"></asp:Label></th>
                                    <th><asp:Label ID="Label3" runat="server" Text="Length"
                                        Width="600px"></asp:Label></th>
                                </tr>
                                <tr id="itemPlaceholder" runat="server"></tr>
                            </table>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <table>
                                <tr style="background-color:aqua">
                                    <td><asp:Label ID="Label1" runat="server" Text="<%#Item.song %>"
                                        Width="600px"></asp:Label></td>
                                    <td><asp:Label ID="Label2" runat="server" Text="<%#Item.length %>"
                                        Width="600px"></asp:Label></td>
                                </tr>
                            </table>
                        </ItemTemplate>
                        <AlternatingItemTemplate>
                            <tr>
                                    <td><asp:Label ID="Label3" runat="server" Text="<%#Item.song %>"
                                        Width="600px"></asp:Label></td>
                                    <td><asp:Label ID="Label4" runat="server" Text="<%#Item.length %>"
                                        Width="600px"></asp:Label></td>
                                </tr>
                        </AlternatingItemTemplate>
                        <EmptyDataTemplate>
                            No data available at this time.
                        </EmptyDataTemplate>
                    </asp:ListView>

                    <%--gridview--%>
                    <%--<asp:GridView ID="TrackList" runat="server" ItemType="Chinook.Data.POCOs.TrackPOCO" DataSource='<%# Item.tracks %>' AutoGenerateColumns="False" GridLines="None">
                        <Columns>
                            <asp:TemplateField HeaderText="Song">
                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text="<%#Item.song %>"
                                        Width="600px"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Length">
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text="<%#Item.length %>"
                                        Width="600px"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataTemplate>
                            No data available at this time.
                        </EmptyDataTemplate>
                    </asp:GridView>--%>

                    <%--<asp:Repeater ID="TrackRepeater" runat="server" DataSource="<%# Item.tracks %>" ItemType="Chinook.Data.POCOs.TrackPOCO">
                        <HeaderTemplate>
                            <table border="1">
                                <tr>
                                    <th>Song</th>
                                    <th>Length</th>
                                </tr>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td style="width: 600px"><a href="https://www.google.ca/search?q=<%# Item.song %>"><%# Item.song %></a></td>
                                <td><%# Item.length %></td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>--%>
                </ItemTemplate>
                <SeparatorTemplate>
                    <hr style="height: 3px; border: none; color: #000; background-color: #000;" />
                </SeparatorTemplate>
            </asp:Repeater>
        </ItemTemplate>

        <SeparatorTemplate>
            <hr style="height: 10px; border: none; color: #ff0000; background-color: #ff0000;" />
        </SeparatorTemplate>
    </asp:Repeater>
    <asp:ObjectDataSource ID="GenreAlbumTrackListODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="Albums_ListforArtist" TypeName="ChinookSystem.BLL.GenreController">
        <SelectParameters>
            <asp:Parameter Name="artistId" Type="Int32"></asp:Parameter>
        </SelectParameters>
    </asp:ObjectDataSource>
    <h1>Genre Album Tracks</h1>
</asp:Content>

