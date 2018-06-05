[Forma]
Clave=AldenComisionBorrador
Nombre=Origen de la Comisión
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Comision
PosicionInicialIzquierda=131
PosicionInicialArriba=106
PosicionInicialAlturaCliente=450
PosicionInicialAncho=802
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
EsConsultaExclusiva=S
Comentarios=Lista(Info.Agente, Info.Nombre)

[Comision]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Comisiones
Clave=Comision
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AldenComision
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Tipo<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=AldenComision.Comision
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
MenuLocal=S
ListaAcciones=(Lista)
IconosNombre=AldenComision:AldenComision.Tipo
FiltroGeneral=AldenComision.AgentID={Info.ID}

[Comision.AldenComision.Comision]
Carpeta=Comision
Clave=AldenComision.Comision
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Comision.Columnas]
0=351
1=151

[Bonos]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Bonos
Clave=Bonos
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AldenBono
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Tipo<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
MenuLocal=S
ListaAcciones=(Lista)
IconosNombre=AldenBono:AldenBono.Tipo
FiltroGeneral=AldenBono.AgentID={Info.ID}

[Bonos.AldenBono.CantidadPedido]
Carpeta=Bonos
Clave=AldenBono.CantidadPedido
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Bonos.AldenBono.CantidadFactura]
Carpeta=Bonos
Clave=AldenBono.CantidadFactura
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Bonos.AldenBono.ImportePedido]
Carpeta=Bonos
Clave=AldenBono.ImportePedido
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Bonos.AldenBono.ImporteFactura]
Carpeta=Bonos
Clave=AldenBono.ImporteFactura
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Bonos.AldenBono.Bono]
Carpeta=Bonos
Clave=AldenBono.Bono
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Bonos.Columnas]
0=238
1=93

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Base]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Base
Clave=Base
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AldenBaseComision
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Tipo<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
MenuLocal=S
ListaAcciones=(Lista)
IconosNombre=AldenBaseComision:AldenComisionBase.Tipo
FiltroGeneral=AldenComisionBase.AgentID={Info.ID}

[Base.AldenComisionBase.VIN]
Carpeta=Base
Clave=AldenComisionBase.VIN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Base.AldenComisionBase.Referencia]
Carpeta=Base
Clave=AldenComisionBase.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Base.AldenComisionBase.Cantidad]
Carpeta=Base
Clave=AldenComisionBase.Cantidad
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Base.AldenComisionBase.Importe]
Carpeta=Base
Clave=AldenComisionBase.Importe
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Base.AldenComisionBase.Costo]
Carpeta=Base
Clave=AldenComisionBase.Costo
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Base.AldenComisionBase.Actividades]
Carpeta=Base
Clave=AldenComisionBase.Actividades
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Base.AldenComisionBase.Gastos]
Carpeta=Base
Clave=AldenComisionBase.Gastos
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Base.Columnas]
0=126
1=165

[Base.VentaMov]
Carpeta=Base
Clave=VentaMov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco
ColorFuente=Negro

[Base.CompraMov]
Carpeta=Base
Clave=CompraMov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.ComisionImprimir]
Nombre=ComisionImprimir
Boton=0
NombreDesplegar=&Imprimir
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.ComisionPreliminar]
Nombre=ComisionPreliminar
Boton=0
NombreDesplegar=Presentación preliminar
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.ComisionExcel]
Nombre=ComisionExcel
Boton=0
NombreDesplegar=Enviar a E&xcel
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.ComisionPersonalizar]
Nombre=ComisionPersonalizar
Boton=0
NombreDesplegar=&Personalizar Vista
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.BonoImprimir]
Nombre=BonoImprimir
Boton=0
NombreDesplegar=&Imprimir
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.BonoPreliminar]
Nombre=BonoPreliminar
Boton=0
NombreDesplegar=&Presentación preliminar
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.BonoExcel]
Nombre=BonoExcel
Boton=0
NombreDesplegar=Enviar a E&xcel
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.BonoPersonalizar]
Nombre=BonoPersonalizar
Boton=0
NombreDesplegar=&Personalizar Vista
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.BaseImprimir]
Nombre=BaseImprimir
Boton=0
NombreDesplegar=&Imprimir
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.BasePreliminar]
Nombre=BasePreliminar
Boton=0
NombreDesplegar=&Presentación preliminar
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.BaseExcel]
Nombre=BaseExcel
Boton=0
NombreDesplegar=Enviar a E&xcel
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.BasePersonalizar]
Nombre=BasePersonalizar
Boton=0
NombreDesplegar=&Personalizar Vista
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Forma.ListaCarpetas]
(Inicio)=Comision
Comision=Bonos
Bonos=Base
Base=(Fin)

[Comision.ListaAcciones]
(Inicio)=ComisionImprimir
ComisionImprimir=ComisionPreliminar
ComisionPreliminar=ComisionExcel
ComisionExcel=ComisionPersonalizar
ComisionPersonalizar=(Fin)

[Bonos.ListaEnCaptura]
(Inicio)=AldenBono.CantidadPedido
AldenBono.CantidadPedido=AldenBono.CantidadFactura
AldenBono.CantidadFactura=AldenBono.ImportePedido
AldenBono.ImportePedido=AldenBono.ImporteFactura
AldenBono.ImporteFactura=AldenBono.Bono
AldenBono.Bono=(Fin)

[Bonos.ListaAcciones]
(Inicio)=BonoImprimir
BonoImprimir=BonoPreliminar
BonoPreliminar=BonoExcel
BonoExcel=BonoPersonalizar
BonoPersonalizar=(Fin)

[Base.ListaEnCaptura]
(Inicio)=AldenComisionBase.VIN
AldenComisionBase.VIN=AldenComisionBase.Referencia
AldenComisionBase.Referencia=AldenComisionBase.Cantidad
AldenComisionBase.Cantidad=AldenComisionBase.Importe
AldenComisionBase.Importe=AldenComisionBase.Costo
AldenComisionBase.Costo=AldenComisionBase.Actividades
AldenComisionBase.Actividades=AldenComisionBase.Gastos
AldenComisionBase.Gastos=VentaMov
VentaMov=CompraMov
CompraMov=(Fin)

[Base.ListaAcciones]
(Inicio)=BaseImprimir
BaseImprimir=BasePreliminar
BasePreliminar=BaseExcel
BaseExcel=BasePersonalizar
BasePersonalizar=(Fin)
