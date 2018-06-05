
[Forma]
Clave=MovExportacionD
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Detalles de Movimiento Exportación
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=(Lista)
CarpetaPrincipal=Detalle
PosicionInicialIzquierda=304
PosicionInicialArriba=273
PosicionInicialAlturaCliente=451
PosicionInicialAncho=735
PosicionCol1=184
ListaAcciones=(Lista)
Comentarios=Lista(Info.Tipo)
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovExportacionD
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
ListaEnCaptura=MovExportacionD.Seccion
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

HojaMantenerSeleccion=S
FiltroGeneral=MovExportacionD.Modulo = <T>{Info.Modulo}<T> AND MovExportacionD.Mov = <T>{Info.Mov}<T> AND MovExportacionD.Exportacion=<T>{Info.Tipo}<T>
[Lista.MovExportacionD.Seccion]
Carpeta=Lista
Clave=MovExportacionD.Seccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco


[Detalle.MovExportacionD.SubSeccionDe]
Carpeta=Detalle
Clave=MovExportacionD.SubSeccionDe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.MovExportacionD.Vista]
Carpeta=Detalle
Clave=MovExportacionD.Vista
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.MovExportacionD.Cierre]
Carpeta=Detalle
Clave=MovExportacionD.Cierre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


Tamano=20
[ExpresionFinal.MovExportacionD.ExpresionFinal]
Carpeta=ExpresionFinal
Clave=MovExportacionD.ExpresionFinal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=72x25
ColorFondo=Blanco

[Lista.Columnas]
Seccion=151

[ExpresionFinal.Columnas]
ExpresionFinal=493

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=Guardar y cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
Activo=S
Visible=S

GuardarAntes=S
ClaveAccion=Aceptar
[Acciones.Registro Insertar]
Nombre=Registro Insertar
Boton=1
NombreEnBoton=S
NombreDesplegar=Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Insertar
Activo=S
Visible=S

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
[Acciones.TablaParseo]
Nombre=TablaParseo
Boton=47
NombreEnBoton=S
NombreDesplegar=Tabla  de Parseo
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=TablaParseoD
Activo=S
Visible=S

Antes=S
AntesExpresiones=Asigna(Info.Numero,MovExportacionD:MovExportacionD.RID)<BR>Asigna(Info.Nombre,MovExportacionD:MovExportacionD.Seccion)<BR>Asigna(Info.Clase1,MovExportacionD:MovExportacionD.Vista)
[Acciones.DiccionarioParseo]
Nombre=DiccionarioParseo
Boton=47
NombreEnBoton=S
NombreDesplegar=Diccionario de Parseo
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=DiccionarioParseoD
Activo=S
Visible=S

Antes=S
AntesExpresiones=Asigna(Info.Numero,MovExportacionD:MovExportacionD.RID)<BR>Asigna(Info.Nombre,MovExportacionD:MovExportacionD.Seccion)

[Detalle.MovExportacionD.Orden]
Carpeta=Detalle
Clave=MovExportacionD.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Tamano=20





[Detalle.MovExportacionD.Seccion]
Carpeta=Detalle
Clave=MovExportacionD.Seccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


















































[ExpresionFinal.ListaEnCaptura]
(Inicio)=MovExportacionD.ExpresionFinal
MovExportacionD.ExpresionFinal=MovExportacionD.Cierre
MovExportacionD.Cierre=(Fin)






























[Detalle]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos Generales
Clave=Detalle
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=MovExportacionD
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
PermiteEditar=S















[Detalle.ListaEnCaptura]
(Inicio)=MovExportacionD.Seccion
MovExportacionD.Seccion=MovExportacionD.Orden
MovExportacionD.Orden=MovExportacionD.SubSeccionDe
MovExportacionD.SubSeccionDe=MovExportacionD.Vista
MovExportacionD.Vista=MovExportacionD.Cierre
MovExportacionD.Cierre=(Fin)



[ExpresionFinal]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Expresión final
Clave=ExpresionFinal
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=MovExportacionD
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
ListaEnCaptura=MovExportacionD.ExpresionFinal
CarpetaVisible=S











[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=ExpresionFinal
ExpresionFinal=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Registro Insertar
Registro Insertar=Registro Eliminar
Registro Eliminar=TablaParseo
TablaParseo=DiccionarioParseo
DiccionarioParseo=(Fin)
