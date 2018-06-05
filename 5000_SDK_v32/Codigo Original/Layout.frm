[Forma]
Clave=Layout
Nombre=Layout<T>s
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=294
PosicionInicialArriba=159
PosicionInicialAlturaCliente=414
PosicionInicialAncho=435
PosicionCol1=220
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Layout
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Layout.Layout
CarpetaVisible=S
HojaMantenerSeleccion=S

[Lista.Layout.Layout]
Carpeta=Lista
Clave=Layout.Layout
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Layout=189

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=Layout
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

[Ficha.Layout.Layout]
Carpeta=Ficha
Clave=Layout.Layout
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Layout.Formato]
Carpeta=Ficha
Clave=Layout.Formato
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Layout.Separador]
Carpeta=Ficha
Clave=Layout.Separador
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Ficha.Layout.TextosEntreComillas]
Carpeta=Ficha
Clave=Layout.TextosEntreComillas
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=25

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

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=E&liminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S
NombreEnBoton=S
ConfirmarAntes=S

[Acciones.Listas]
Nombre=Listas
Boton=47
NombreEnBoton=S
NombreDesplegar=Lista&s
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=LayoutLista
Visible=S
GuardarAntes=S
ConCondicion=S
Antes=S
ActivoCondicion=Layout:Layout.Formato<><T>INI Dinamico<T>
EjecucionCondicion=ConDatos(Layout:Layout.Layout)
AntesExpresiones=Asigna(Ver.Columna, Nulo)<BR>Asigna(Ver.Columna2, Nulo)<BR>Asigna(Info.Layout, Layout:Layout.Layout)<BR>Asigna(Info.Formato, Layout:Layout.Formato)<BR>Si(Layout:Layout.VerTipoDatos, Asigna(Ver.Columna, <T>TipoDatos<T>))<BR>Si(Izquierda(Info.Formato, 3)<><T>INI<T>, Asigna(Ver.Columna2, Layout:Layout.IDLista))

[Ficha.Layout.VerTipoDatos]
Carpeta=Ficha
Clave=Layout.VerTipoDatos
Editar=S
LineaNueva=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Layout.Codificacion]
Carpeta=Ficha
Clave=Layout.Codificacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Layout.Nombre]
Carpeta=Ficha
Clave=Layout.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Layout.IDLista]
Carpeta=Ficha
Clave=Layout.IDLista
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.Layout.InsertarVacios]
Carpeta=Ficha
Clave=Layout.InsertarVacios
Editar=S
LineaNueva=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 1 (Registros)
Activo=S
Visible=S

[Ficha.Layout.TieneEstructura]
Carpeta=Ficha
Clave=Layout.TieneEstructura
Editar=S
LineaNueva=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=Listas
Listas=Navegador
Navegador=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=Layout.Layout
Layout.Layout=Layout.Nombre
Layout.Nombre=Layout.Formato
Layout.Formato=Layout.Codificacion
Layout.Codificacion=Layout.IDLista
Layout.IDLista=Layout.VerTipoDatos
Layout.VerTipoDatos=Layout.InsertarVacios
Layout.InsertarVacios=Layout.TieneEstructura
Layout.TieneEstructura=Layout.TextosEntreComillas
Layout.TextosEntreComillas=Layout.Separador
Layout.Separador=(Fin)
