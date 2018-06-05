[Forma]
Clave=MovProv
Nombre=Generar Movimiento
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=802
PosicionInicialArriba=420
PosicionInicialAlturaCliente=323
PosicionInicialAncho=324
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Info.Proveedor
ExpresionesAlCerrar=Asigna(Filtro.Cliente, Nulo)<BR>Asigna(Filtro.Mov, Nulo)

[Lista]
Estilo=Hoja
Clave=Lista
Zona=A1
Vista=MovProv
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
OtroOrden=S
ListaOrden=MovProv.Orden<TAB>(Acendente)
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaMantenerSeleccion=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
ListaEnCaptura=MovProv.Nombre

[Lista.Columnas]
0=363
Nombre=287

[Acciones.Generar]
Nombre=Generar
Boton=23
NombreEnBoton=S
NombreDesplegar=<T>&Generar<T>
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
ConCondicion=S
Expresion=Caso MovProv:MovProv.Tipo<BR>  Es <T>Modulo<T>        <BR>    Entonces <BR>      Asigna(Filtro.Proveedor, Info.Proveedor) <BR>      Asigna(Filtro.Mov, MovProv:MovProv.Mov)<BR>      Caso MovProv:MovProv.Modulo<BR>        Es <T>COMS<T> Entonces <BR>                    Forma(<T>Compra<T>)<BR>        Es <T>GAS<T> Entonces <BR>                    Forma(<T>Gasto<T>)<BR>        Es <T>ST<T>   Entonces <BR>                    Asigna(Info.SubModuloST, Vacio(MovProv:MovProv.SubModulo, MovProv:MovProv.SubModulo)) <BR>                    Asigna(Info.STNombre, SQL(<T>SELECT Nombre FROM SubModulo WHERE Modulo=:tModulo AND SubModulo=:tSubModulo<T>, MovProv:MovProv.Modulo, Info.SubModuloST))<BR>                    Forma(<T>Soporte<T>)<BR>        Es <T>CXP<T>  Entonces <BR>                    Forma(<T>Cxp<T>)<BR>      Fin<BR>Fin
EjecucionCondicion=ConDatos(MovProv:MovProv.Nombre) y ConDatos(MovProv:MovProv.Tipo)

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Lista.MovProv.Nombre]
Carpeta=Lista
Clave=MovProv.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Generar
Generar=Cancelar
Cancelar=(Fin)
