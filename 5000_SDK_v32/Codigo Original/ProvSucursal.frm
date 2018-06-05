[Forma]
Clave=ProvSucursal
Nombre=<T>Sucursales del Proveedor<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Detalle
PosicionInicialIzquierda=1557
PosicionInicialArriba=132
PosicionInicialAltura=564
PosicionInicialAncho=598
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Info.Proveedor
VentanaExclusiva=S
BarraAyuda=S
PosicionSeccion1=37
ExpresionesAlMostrar=Asigna(Info.Copiar, Falso)
PosicionInicialAlturaProveedor=575
PosicionInicialAlturaCliente=565

PosicionSec1=185
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProvSucursal
Fuente={MS Sans Serif, 8, Negro, []}
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
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Lista
HojaMantenerSeleccion=S
Filtros=S
FiltroPredefinido=S
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=30
OtroOrden=S
ListaOrden=(Lista)
FiltroTodo=S
FiltroGeneral=ProvSucursal.Proveedor={Comillas(Info.Proveedor)}

[Lista.ProvSucursal.Nombre]
Carpeta=Lista
Clave=ProvSucursal.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco
ColorFuente=Negro

[Detalle]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos Generales
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=ProvSucursal
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

[Detalle.ProvSucursal.Nombre]
Carpeta=Detalle
Clave=ProvSucursal.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=44
ColorFondo=Blanco
Efectos=[Negritas]

[Detalle.ProvSucursal.Telefonos]
Carpeta=Detalle
Clave=ProvSucursal.Telefonos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
EspacioPrevio=S
ColorFondo=Blanco

[Detalle.ProvSucursal.Fax]
Carpeta=Detalle
Clave=ProvSucursal.Fax
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.ProvSucursal.Contacto1]
Carpeta=Detalle
Clave=ProvSucursal.Contacto1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Detalle.ProvSucursal.Contacto2]
Carpeta=Detalle
Clave=ProvSucursal.Contacto2
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=29
ColorFondo=Blanco

[Detalle.ProvSucursal.eMail1]
Carpeta=Detalle
Clave=ProvSucursal.eMail1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Detalle.ProvSucursal.eMail2]
Carpeta=Detalle
Clave=ProvSucursal.eMail2
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=34
ColorFondo=Blanco

[Lista.Columnas]
EnviarA=76
Nombre=252
ID=57
Direccion=249

[Lista.ProvSucursal.Direccion]
Carpeta=Lista
Clave=ProvSucursal.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=250
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
Visible=S
Activo=S
GuardarAntes=S

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=&Nueva
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Visible=S
Activo=S
GuardarAntes=S
NombreEnBoton=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=E&liminar
EnBarraHerramientas=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Visible=S
ConfirmarAntes=S
NombreEnBoton=S
ActivoCondicion=no ProvSucursal:ProvSucursal.TieneMovimientos

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 1 (Registros)
Visible=S
Activo=S

[Detalle.ProvSucursal.ID]
Carpeta=Detalle
Clave=ProvSucursal.ID
3D=S
Tamano=10
Efectos=[Negritas]
Editar=S
ColorFondo=Blanco
Pegado=S

[Notas.ProvSucursal.Notas]
Carpeta=Notas
Clave=ProvSucursal.Notas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=75x17

[Notas.ProvSucursal.Mensaje]
Carpeta=Notas
Clave=ProvSucursal.Mensaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=75x3

[Lista.ProvSucursal.ID]
Carpeta=Lista
Clave=ProvSucursal.ID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ProvSucursal.Extencion1]
Carpeta=Detalle
Clave=ProvSucursal.Extencion1
Editar=S
3D=S
Tamano=5
ColorFondo=Blanco
Pegado=S

[Detalle.ProvSucursal.Extencion2]
Carpeta=Detalle
Clave=ProvSucursal.Extencion2
Editar=S
3D=S
Tamano=5
ColorFondo=Blanco
Pegado=S

[Detalle.ProvSucursal.Observaciones]
Carpeta=Detalle
Clave=ProvSucursal.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
EspacioPrevio=N

[Detalle.ProvSucursal.Agente]
Carpeta=Detalle
Clave=ProvSucursal.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
EspacioPrevio=S

[Detalle.ProvSucursal.Estatus]
Carpeta=Detalle
Clave=ProvSucursal.Estatus
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.ProvSucursal.Categoria]
Carpeta=Detalle
Clave=ProvSucursal.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Detalle.ProvSucursal.Grupo]
Carpeta=Detalle
Clave=ProvSucursal.Grupo
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
LineaNueva=S

[Detalle.ProvSucursal.Familia]
Carpeta=Detalle
Clave=ProvSucursal.Familia
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
LineaNueva=N

[Direccion]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Dirección
Clave=Direccion
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=ProvSucursal
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=95
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Direccion.ProvSucursal.Nombre]
Carpeta=Direccion
Clave=ProvSucursal.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=44
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Direccion.ProvSucursal.ID]
Carpeta=Direccion
Clave=ProvSucursal.ID
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Direccion.ProvSucursal.Direccion]
Carpeta=Direccion
Clave=ProvSucursal.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=53
ColorFondo=Blanco
ColorFuente=Negro

[Direccion.ProvSucursal.EntreCalles]
Carpeta=Direccion
Clave=ProvSucursal.EntreCalles
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Direccion.ProvSucursal.Plano]
Carpeta=Direccion
Clave=ProvSucursal.Plano
Editar=S
LineaNueva=N
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
ValidaNombre=S

[Direccion.ProvSucursal.Colonia]
Carpeta=Direccion
Clave=ProvSucursal.Colonia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Direccion.ProvSucursal.CodigoPostal]
Carpeta=Direccion
Clave=ProvSucursal.CodigoPostal
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Direccion.ProvSucursal.Poblacion]
Carpeta=Direccion
Clave=ProvSucursal.Poblacion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Direccion.ProvSucursal.Estado]
Carpeta=Direccion
Clave=ProvSucursal.Estado
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Direccion.ProvSucursal.Pais]
Carpeta=Direccion
Clave=ProvSucursal.Pais
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Direccion.ProvSucursal.Delegacion]
Carpeta=Direccion
Clave=ProvSucursal.Delegacion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Direccion.ProvSucursal.Observaciones]
Carpeta=Direccion
Clave=ProvSucursal.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Direccion.ProvSucursal.Ruta]
Carpeta=Direccion
Clave=ProvSucursal.Ruta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ProvSucursal.Contrasena]
Carpeta=Detalle
Clave=ProvSucursal.Contrasena
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.ProvSucursal.Clave]
Carpeta=Detalle
Clave=ProvSucursal.Clave
Editar=S
3D=S
Tamano=10
ColorFondo=Blanco
Efectos=[Negritas]

[Detalle.ProvSucursal.eMailAuto]
Carpeta=Detalle
Clave=ProvSucursal.eMailAuto
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

[Direccion.ProvSucursal.Zona]
Carpeta=Direccion
Clave=ProvSucursal.Zona
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ProvSucursal.Encargado]
Carpeta=Detalle
Clave=ProvSucursal.Encargado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Direccion.ProvSucursal.DireccionNumero]
Carpeta=Direccion
Clave=ProvSucursal.DireccionNumero
Editar=S
3D=S
Pegado=S
Tamano=6
ColorFondo=Blanco
ColorFuente=Negro

[Direccion.ProvSucursal.GLN]
Carpeta=Direccion
Clave=ProvSucursal.GLN
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Direccion.ProvSucursal.DireccionNumeroInt]
Carpeta=Direccion
Clave=ProvSucursal.DireccionNumeroInt
Editar=S
3D=S
Pegado=S
Tamano=6
ColorFondo=Blanco
ColorFuente=Negro



[Lista.ListaEnCaptura]
(Inicio)=ProvSucursal.ID
ProvSucursal.ID=ProvSucursal.Nombre
ProvSucursal.Nombre=ProvSucursal.Direccion
ProvSucursal.Direccion=(Fin)

[Lista.ListaOrden]
(Inicio)=ProvSucursal.Proveedor<TAB>(Acendente)
ProvSucursal.Proveedor<TAB>(Acendente)=ProvSucursal.ID<TAB>(Acendente)
ProvSucursal.ID<TAB>(Acendente)=(Fin)


[Direccion.ListaEnCaptura]
(Inicio)=ProvSucursal.Nombre
ProvSucursal.Nombre=ProvSucursal.ID
ProvSucursal.ID=ProvSucursal.Direccion
ProvSucursal.Direccion=ProvSucursal.DireccionNumero
ProvSucursal.DireccionNumero=ProvSucursal.DireccionNumeroInt
ProvSucursal.DireccionNumeroInt=ProvSucursal.EntreCalles
ProvSucursal.EntreCalles=ProvSucursal.Plano
ProvSucursal.Plano=ProvSucursal.Observaciones
ProvSucursal.Observaciones=ProvSucursal.Delegacion
ProvSucursal.Delegacion=ProvSucursal.Colonia
ProvSucursal.Colonia=ProvSucursal.CodigoPostal
ProvSucursal.CodigoPostal=ProvSucursal.Ruta
ProvSucursal.Ruta=ProvSucursal.Poblacion
ProvSucursal.Poblacion=ProvSucursal.Estado
ProvSucursal.Estado=ProvSucursal.Pais
ProvSucursal.Pais=ProvSucursal.Zona
ProvSucursal.Zona=ProvSucursal.GLN
ProvSucursal.GLN=(Fin)



[Detalle.ListaEnCaptura]
(Inicio)=ProvSucursal.Nombre
ProvSucursal.Nombre=ProvSucursal.Clave
ProvSucursal.Clave=ProvSucursal.ID
ProvSucursal.ID=ProvSucursal.Categoria
ProvSucursal.Categoria=ProvSucursal.Estatus
ProvSucursal.Estatus=ProvSucursal.Grupo
ProvSucursal.Grupo=ProvSucursal.Familia
ProvSucursal.Familia=ProvSucursal.Encargado
ProvSucursal.Encargado=ProvSucursal.Telefonos
ProvSucursal.Telefonos=ProvSucursal.Fax
ProvSucursal.Fax=ProvSucursal.Contacto1
ProvSucursal.Contacto1=ProvSucursal.Extencion1
ProvSucursal.Extencion1=ProvSucursal.Contacto2
ProvSucursal.Contacto2=ProvSucursal.Extencion2
ProvSucursal.Extencion2=ProvSucursal.eMail1
ProvSucursal.eMail1=ProvSucursal.eMail2
ProvSucursal.eMail2=ProvSucursal.eMailAuto
ProvSucursal.eMailAuto=ProvSucursal.Agente
ProvSucursal.Agente=ProvSucursal.Observaciones
ProvSucursal.Observaciones=ProvSucursal.Contrasena
ProvSucursal.Contrasena=(Fin)

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=Direccion
Direccion=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=Navegador
Navegador=(Fin)
