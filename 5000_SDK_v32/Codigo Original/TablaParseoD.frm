
[Forma]
Clave=TablaParseoD
Icono=0
CarpetaPrincipal=TagLimpiar
Modulos=(Todos)
Nombre=Tabla de Parseo
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=(Lista)
PosicionInicialAlturaCliente=449
PosicionInicialAncho=720
ListaAcciones=(Lista)
BarraHerramientas=S
Comentarios=Lista(Info.Tipo,Info.Nombre)
PosicionInicialIzquierda=344
PosicionInicialArriba=293
PosicionCol1=329
[TablaParseoD]
Estilo=Hoja
Clave=TablaParseoD
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TablaParseoD
Fuente={Tahoma, 8, Negro, []}
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




PestanaOtroNombre=S
PestanaNombre=Datos Generales
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
HojaMantenerSeleccion=S
FiltroGeneral=TablaParseoD.Exportacion=<T>{Info.Tipo}<T> AND TablaParseoD.IDSeccion = {Info.Numero}
[TablaParseoD.TablaParseoD.CampoXML]
Carpeta=TablaParseoD
Clave=TablaParseoD.CampoXML
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[TablaParseoD.TablaParseoD.CampoIntelisis]
Carpeta=TablaParseoD
Clave=TablaParseoD.CampoIntelisis
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[TablaParseoD.TablaParseoD.Formato]
Carpeta=TablaParseoD
Clave=TablaParseoD.Formato
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco


[TablaParseoD.Columnas]
Exportacion=115
IDSeccion=64
RID=64
CampoXML=89
CampoIntelisis=106
Formato=99
Traducir=64
Opcional=64
TagLimpiar=70

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreDesplegar=Guardar y cerrar
GuardarAntes=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
NombreEnBoton=S
EnBarraHerramientas=S

[Acciones.Documento Nuevo]
Nombre=Documento Nuevo
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
EspacioPrevio=S
ConfirmarAntes=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

[Acciones.Navegador Completo (Registros)]
Nombre=Navegador Completo (Registros)
Boton=0
NombreDesplegar=Navegador Completo (Registros)
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador Completo (Registros)
Activo=S
Visible=S





[TagLimpiar]
Estilo=Ficha
PestanaOtroNombre=S
PestanaNombre=Tag Limpiar
Clave=TagLimpiar
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=TablaParseoD
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
ListaEnCaptura=(Lista)
CarpetaVisible=S

[TagLimpiar.TablaParseoD.TagLimpiar]
Carpeta=TagLimpiar
Clave=TablaParseoD.TagLimpiar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Tamano=50x10

[TagLimpiar.TablaParseoD.Opcional]
Carpeta=TagLimpiar
Clave=TablaParseoD.Opcional
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[TagLimpiar.TablaParseoD.Traducir]
Carpeta=TagLimpiar
Clave=TablaParseoD.Traducir
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Tamano=



[TablaParseoD.ListaEnCaptura]
(Inicio)=TablaParseoD.CampoXML
TablaParseoD.CampoXML=TablaParseoD.CampoIntelisis
TablaParseoD.CampoIntelisis=TablaParseoD.Formato
TablaParseoD.Formato=(Fin)





[TagLimpiar.TablaParseoD.CampoXML]
Carpeta=TagLimpiar
Clave=TablaParseoD.CampoXML
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[TagLimpiar.TablaParseoD.CampoIntelisis]
Carpeta=TagLimpiar
Clave=TablaParseoD.CampoIntelisis
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[TagLimpiar.TablaParseoD.Formato]
Carpeta=TagLimpiar
Clave=TablaParseoD.Formato
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco



[TagLimpiar.ListaEnCaptura]
(Inicio)=TablaParseoD.CampoXML
TablaParseoD.CampoXML=TablaParseoD.CampoIntelisis
TablaParseoD.CampoIntelisis=TablaParseoD.Formato
TablaParseoD.Formato=TablaParseoD.Traducir
TablaParseoD.Traducir=TablaParseoD.Opcional
TablaParseoD.Opcional=TablaParseoD.TagLimpiar
TablaParseoD.TagLimpiar=(Fin)







[Forma.ListaCarpetas]
(Inicio)=TablaParseoD
TablaParseoD=TagLimpiar
TagLimpiar=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Documento Nuevo
Documento Nuevo=Registro Eliminar
Registro Eliminar=Navegador Completo (Registros)
Navegador Completo (Registros)=(Fin)
