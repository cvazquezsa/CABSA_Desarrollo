[Forma]
Clave=CteCtoDireccion
Nombre=Direcciones del Contacto
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Lista(Info.Cliente, Info.Nombre)
PosicionInicialIzquierda=86
PosicionInicialArriba=173
PosicionInicialAlturaCliente=387
PosicionInicialAncho=807
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CteCtoDireccion
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
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
FiltroGeneral=CteCtoDireccion.Cliente=<T>{Info.Cliente}<T> AND CteCtoDireccion.ID={Info.ID}

[Lista.CteCtoDireccion.Direccion]
Carpeta=Lista
Clave=CteCtoDireccion.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
GuardarAntes=S

[Lista.Columnas]
Direccion=177
Cargo=248
Tipo=61
Delegacion=109
Colonia=105
Poblacion=98
Estado=87
Pais=64
Zona=69
CodigoPostal=70

[Lista.CteCtoDireccion.Tipo]
Carpeta=Lista
Clave=CteCtoDireccion.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CteCtoDireccion.Delegacion]
Carpeta=Lista
Clave=CteCtoDireccion.Delegacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CteCtoDireccion.Colonia]
Carpeta=Lista
Clave=CteCtoDireccion.Colonia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CteCtoDireccion.Poblacion]
Carpeta=Lista
Clave=CteCtoDireccion.Poblacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CteCtoDireccion.Estado]
Carpeta=Lista
Clave=CteCtoDireccion.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CteCtoDireccion.Pais]
Carpeta=Lista
Clave=CteCtoDireccion.Pais
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CteCtoDireccion.CodigoPostal]
Carpeta=Lista
Clave=CteCtoDireccion.CodigoPostal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=CteCtoDireccion.Tipo
CteCtoDireccion.Tipo=CteCtoDireccion.Direccion
CteCtoDireccion.Direccion=CteCtoDireccion.Colonia
CteCtoDireccion.Colonia=CteCtoDireccion.Delegacion
CteCtoDireccion.Delegacion=CteCtoDireccion.Poblacion
CteCtoDireccion.Poblacion=CteCtoDireccion.CodigoPostal
CteCtoDireccion.CodigoPostal=CteCtoDireccion.Estado
CteCtoDireccion.Estado=CteCtoDireccion.Pais
CteCtoDireccion.Pais=(Fin)
