[Forma]
Clave=GastoCampos
Nombre=Info.Mov+<T> <T>+Info.MovID
Icono=0
Modulos=(Todos)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=315
PosicionInicialArriba=279
PosicionInicialAltura=124
PosicionInicialAncho=394
PosicionInicialAlturaCliente=176
Comentarios=Lista(Info.Mov, Info.MovID)

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=GastoCampos
Fuente={MS Sans Serif, 8, Negro, []}
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
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=Gasto.ID={Info.ID}

[Ficha.Gasto.Condicion]
Carpeta=Ficha
Clave=Gasto.Condicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.Gasto.Vencimiento]
Carpeta=Ficha
Clave=Gasto.Vencimiento
Editar=S
EditarConBloqueo=S
3D=S
Tamano=19
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

[Ficha.Gasto.Observaciones]
Carpeta=Ficha
Clave=Gasto.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Ficha.Gasto.FechaRequerida]
Carpeta=Ficha
Clave=Gasto.FechaRequerida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Ficha.Gasto.Proyecto]
Carpeta=Ficha
Clave=Gasto.Proyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Ficha.Gasto.UEN]
Carpeta=Ficha
Clave=Gasto.UEN
Editar=S
3D=S
Tamano=9
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Ficha.Gasto.Clase]
Carpeta=Ficha
Clave=Gasto.Clase
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Gasto.SubClase]
Carpeta=Ficha
Clave=Gasto.SubClase
Editar=S
ValidaNombre=N
3D=S
Tamano=19
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.ListaEnCaptura]
(Inicio)=Gasto.Proyecto
Gasto.Proyecto=Gasto.UEN
Gasto.UEN=Gasto.Observaciones
Gasto.Observaciones=Gasto.FechaRequerida
Gasto.FechaRequerida=Gasto.Condicion
Gasto.Condicion=Gasto.Vencimiento
Gasto.Vencimiento=Gasto.Clase
Gasto.Clase=Gasto.SubClase
Gasto.SubClase=(Fin)
