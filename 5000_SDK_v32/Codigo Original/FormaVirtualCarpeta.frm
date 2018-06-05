[Forma]
Clave=FormaVirtualCarpeta
Nombre=Carpetas de la Forma Virtual
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=490
PosicionInicialArriba=419
PosicionInicialAlturaCliente=328
PosicionInicialAncho=940
PosicionCol1=751
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
Comentarios=Info.FormaVirtual

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=FormaVirtualCarpeta
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaAjustarColumnas=S
HojaColoresPorEstatus=S
HojaMantenerSeleccion=S
HojaVistaOmision=Automática
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
OtroOrden=S
ListaOrden=(Lista)
FiltroGeneral=FormaVirtualCarpeta.FormaVirtual=<T>{Info.FormaVirtual}<T>

[Lista.FormaVirtualCarpeta.Carpeta]
Carpeta=Lista
Clave=FormaVirtualCarpeta.Carpeta
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFondo=Plata
ColorFuente=Negro

[Lista.FormaVirtualCarpeta.Etiqueta]
Carpeta=Lista
Clave=FormaVirtualCarpeta.Etiqueta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
Carpeta=192
Etiqueta=269
Invisible=46
Nombre=216
Pagina=39
Orden=35
Visible=40

[Ficha]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Etiquetas Filtros
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=FormaVirtualCarpeta
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

[Ficha.FormaVirtualCarpeta.Filtro1]
Carpeta=Ficha
Clave=FormaVirtualCarpeta.Filtro1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.FormaVirtualCarpeta.Filtro2]
Carpeta=Ficha
Clave=FormaVirtualCarpeta.Filtro2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.FormaVirtualCarpeta.Filtro3]
Carpeta=Ficha
Clave=FormaVirtualCarpeta.Filtro3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.FormaVirtualCarpeta.Filtro4]
Carpeta=Ficha
Clave=FormaVirtualCarpeta.Filtro4
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.FormaVirtualCarpeta.Filtro5]
Carpeta=Ficha
Clave=FormaVirtualCarpeta.Filtro5
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.FormaVirtualCarpeta.Filtro6]
Carpeta=Ficha
Clave=FormaVirtualCarpeta.Filtro6
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.FormaVirtualCarpeta.Nombre]
Carpeta=Lista
Clave=FormaVirtualCarpeta.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Plata
ColorFuente=Negro

[Lista.FormaVirtualCarpeta.Visible]
Carpeta=Lista
Clave=FormaVirtualCarpeta.Visible
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Ordenar]
Nombre=Ordenar
Boton=50
NombreDesplegar=Cambiar el Orden
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Antes=S
AntesExpresiones=Forma(<T>FormaVirtualCarpetaOrdenar<T>)
Visible=S

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Ordenar
Ordenar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=FormaVirtualCarpeta.Carpeta
FormaVirtualCarpeta.Carpeta=FormaVirtualCarpeta.Nombre
FormaVirtualCarpeta.Nombre=FormaVirtualCarpeta.Etiqueta
FormaVirtualCarpeta.Etiqueta=FormaVirtualCarpeta.Visible
FormaVirtualCarpeta.Visible=(Fin)

[Lista.ListaOrden]
(Inicio)=FormaVirtualCarpeta.Orden<TAB>(Acendente)
FormaVirtualCarpeta.Orden<TAB>(Acendente)=FormaVirtualCarpeta.Pagina<TAB>(Acendente)
FormaVirtualCarpeta.Pagina<TAB>(Acendente)=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=FormaVirtualCarpeta.Filtro1
FormaVirtualCarpeta.Filtro1=FormaVirtualCarpeta.Filtro2
FormaVirtualCarpeta.Filtro2=FormaVirtualCarpeta.Filtro3
FormaVirtualCarpeta.Filtro3=FormaVirtualCarpeta.Filtro4
FormaVirtualCarpeta.Filtro4=FormaVirtualCarpeta.Filtro5
FormaVirtualCarpeta.Filtro5=FormaVirtualCarpeta.Filtro6
FormaVirtualCarpeta.Filtro6=(Fin)
