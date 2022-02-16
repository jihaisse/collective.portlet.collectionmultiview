from zope.browserpage.viewpagetemplatefile import ViewPageTemplateFile
from collective.portlet.collectionmultiview import BaseRenderer
from collective.portlet.collectionmultiview.renderers.default import IDefaultSchema


class IColumnRenderer(IDefaultSchema):
    """

    """


class ColumnRenderer(BaseRenderer):
    """ display items in a single row table """

    title = 'Column Renderer'
    template = ViewPageTemplateFile('templates/column.pt')
    schema = IColumnRenderer
