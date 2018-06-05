[Forma]
Clave=NomXDin
Nombre=Tesorería
Icono=34
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=272
PosicionInicialArriba=223
PosicionInicialAltura=487
PosicionInicialAncho=736
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionColumna1=29
Comentarios=Info.Nombre
PosicionInicialAlturaCliente=544

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NomXDin
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=NomXDin.Concepto
CarpetaVisible=S
HojaMantenerSeleccion=S
Filtros=S
OtroOrden=S
ListaOrden=NomXDin.Orden<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=NomXDin.ID={Info.ID}

[Lista.NomXDin.Concepto]
Carpeta=Lista
Clave=NomXDin.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Concepto=179

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=NomXDin
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

[Ficha.NomXDin.Concepto]
Carpeta=Ficha
Clave=NomXDin.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.NomXDin.Condicion]
Carpeta=Ficha
Clave=NomXDin.Condicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60x3
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.NomXDin.Comentarios]
Carpeta=Ficha
Clave=NomXDin.Comentarios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+N
NombreDesplegar=Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Insertar
Activo=S
Visible=S
NombreEnBoton=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
Menu=&Archivo
NombreDesplegar=E&liminar
EnBarraHerramientas=S
EnMenu=S
ConfirmarAntes=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S
NombreEnBoton=S

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 1 (Registros)
Activo=S
Visible=S
EnBarraHerramientas=S

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

[Acciones.Guardar]
Nombre=Guardar
Boton=3
Menu=&Archivo
NombreDesplegar=&Guardar
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
ConCondicion=S
EjecucionConError=S
Visible=S
EspacioPrevio=S
NombreEnBoton=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(NomXDin:NomXDin.Concepto)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>

[Ficha.NomXDin.Movimiento]
Carpeta=Ficha
Clave=NomXDin.Movimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60x3
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.NomXDin.Cuenta]
Carpeta=Ficha
Clave=NomXDin.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60x3
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.NomXDin.Beneficiario]
Carpeta=Ficha
Clave=NomXDin.Beneficiario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60x3
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.NomXDin.Importe]
Carpeta=Ficha
Clave=NomXDin.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60x3
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.NomXDin.FormaPago]
Carpeta=Ficha
Clave=NomXDin.FormaPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60x3
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.NomXDin.Referencia]
Carpeta=Ficha
Clave=NomXDin.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60x3
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.NomXDin.Personal]
Carpeta=Ficha
Clave=NomXDin.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60x3
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Guardar
Guardar=Nuevo
Nuevo=Eliminar
Eliminar=Navegador
Navegador=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=NomXDin.Concepto
NomXDin.Concepto=NomXDin.Movimiento
NomXDin.Movimiento=NomXDin.Cuenta
NomXDin.Cuenta=NomXDin.Beneficiario
NomXDin.Beneficiario=NomXDin.Importe
NomXDin.Importe=NomXDin.FormaPago
NomXDin.FormaPago=NomXDin.Referencia
NomXDin.Referencia=NomXDin.Personal
NomXDin.Personal=NomXDin.Condicion
NomXDin.Condicion=NomXDin.Comentarios
NomXDin.Comentarios=(Fin)
