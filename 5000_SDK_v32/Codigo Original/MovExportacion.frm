
[Forma]
Clave=MovExportacion
Icono=0
CarpetaPrincipal=MovExportacion
Modulos=(Todos)
Nombre=Movimiento Exportacion

ListaCarpetas=(Lista)
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=210
PosicionInicialArriba=292
PosicionInicialAlturaCliente=452
PosicionInicialAncho=882
PosicionCol1=334





Comentarios=Lista(Info.Modulo,Info.Mov)
[Acciones.Navegador Completo (Registros)]
Nombre=Navegador Completo (Registros)
Boton=0
NombreDesplegar=Navegador Completo (Registros)
EnBarraHerramientas=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador Completo (Registros)
Activo=S
Visible=S

EspacioPrevio=S
[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=Guardar y cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

GuardarAntes=S
[Acciones.Documento Nuevo]
Nombre=Documento Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=Nuevo
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S
EspacioPrevio=S
Carpeta=(Carpeta principal)

[Acciones.Registro Eliminar]
Nombre=Registro Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=Eliminar
EnBarraHerramientas=S
ConfirmarAntes=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

EspacioPrevio=S
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovExportacion
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=MovExportacion.Exportacion
CarpetaVisible=S

PestanaOtroNombre=S
PestanaNombre=Movimientos
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=MovExportacion.Modulo=<T>{Info.Modulo}<T> AND MovExportacion.Mov = <T>{Info.Mov}<T>
[Lista.MovExportacion.Exportacion]
Carpeta=Lista
Clave=MovExportacion.Exportacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.Columnas]
Exportacion=305

[MovExportacion1]
Estilo=Ficha
Pestana=S
Clave=MovExportacion1
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=MovExportacion
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=MovExportacion.Documento
CarpetaVisible=S

PestanaOtroNombre=S
PestanaNombre=Documento XML
GuardarAlSalir=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=MovExportacion.Modulo=<T>{Info.Modulo}<T> AND MovExportacion.Mov = <T>{Info.Mov}<T>
[MovExportacion1.MovExportacion.Documento]
Carpeta=MovExportacion1
Clave=MovExportacion.Documento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=72x25
IgnoraFlujo=S
[MovExportacion2]
Estilo=Ficha
Pestana=S
Clave=MovExportacion2
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=movexportacion
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=MovExportacion.DocumentoXSD
CarpetaVisible=S

PestanaOtroNombre=S
PestanaNombre=Documento XSD
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=MovExportacion.Modulo=<T>{Info.Modulo}<T> AND MovExportacion.Mov = <T>{Info.Mov}<T>
FiltroRespetar=S
FiltroTipo=General
[MovExportacion2.MovExportacion.DocumentoXSD]
Carpeta=MovExportacion2
Clave=MovExportacion.DocumentoXSD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=72x25
ColorFondo=Blanco

[MovExportacion3]
Estilo=Ficha
Pestana=S
Clave=MovExportacion3
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=Movexportacion
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=MovExportacion.DocumentoXSL
CarpetaVisible=S

PestanaOtroNombre=S
PestanaNombre=Documento XSL
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=MovExportacion.Modulo=<T>{Info.Modulo}<T> AND MovExportacion.Mov = <T>{Info.Mov}<T>
FiltroRespetar=S
FiltroTipo=General
[MovExportacion3.MovExportacion.DocumentoXSL]
Carpeta=MovExportacion3
Clave=MovExportacion.DocumentoXSL
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=72x25
ColorFondo=Blanco






[MovExportacion]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos Generales
Clave=MovExportacion
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=MovExportacion
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=209
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=MovExportacion.Modulo=<T>{Info.Modulo}<T> AND MovExportacion.Mov = <T>{Info.Mov}<T>
[MovExportacion.MovExportacion.Exportacion]
Carpeta=MovExportacion
Clave=MovExportacion.Exportacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

Efectos=[Negritas]


[MovExportacion.MovExportacion.Codificacion]
Carpeta=MovExportacion
Clave=MovExportacion.Codificacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
Efectos=[Negritas]

[Acciones.Detalle]
Nombre=Detalle
Boton=47
NombreEnBoton=S
NombreDesplegar=Detalle
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MovExportacionD
Activo=S
Visible=S
Antes=S



AntesExpresiones=Asigna(Info.Tipo, MovExportacion:MovExportacion.Exportacion)












[MovExportacion.ListaEnCaptura]
(Inicio)=MovExportacion.Exportacion
MovExportacion.Exportacion=MovExportacion.Codificacion
MovExportacion.Codificacion=(Fin)







[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=MovExportacion
MovExportacion=MovExportacion1
MovExportacion1=MovExportacion2
MovExportacion2=MovExportacion3
MovExportacion3=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Documento Nuevo
Documento Nuevo=Registro Eliminar
Registro Eliminar=Detalle
Detalle=Navegador Completo (Registros)
Navegador Completo (Registros)=(Fin)
